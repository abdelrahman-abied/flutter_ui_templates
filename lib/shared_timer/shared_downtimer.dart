import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a state class for the timer
class TimerState {
  final int minutes;
  final int seconds;
  final bool isRunning;

  TimerState({
    required this.minutes,
    required this.seconds,
    required this.isRunning,
  });
  // to json
  Map<String, dynamic> toJson() {
    return {
      'minutes': minutes,
      'seconds': seconds,
      'isRunning': isRunning,
    };
  }
}

// Create a provider for the timer state
final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier(
    initialMinutes: 1,
    initialSeconds: 0,
  )..start();
});

// Define a notifier class to manage the timer logic
class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier({
    required int initialMinutes,
    required int initialSeconds,
  }) : super(TimerState(
          minutes: initialMinutes,
          seconds: initialSeconds,
          isRunning: false,
        ));

  Timer? _timer;

  // Start the timer
  void start() {
    if (state.isRunning) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.seconds > 0) {
        state = TimerState(
          minutes: state.minutes,
          seconds: state.seconds - 1,
          isRunning: true,
        );
      } else if (state.minutes > 0) {
        state = TimerState(
          minutes: state.minutes - 1,
          seconds: 59,
          isRunning: true,
        );
      } else {
        // Timer ended
        stop();
        // Reset the timer
        reset();
      }
      debugPrint(state.toJson().toString());
    });
  }

  // Stop the timer
  void stop() {
    _timer?.cancel();
    state = TimerState(
      minutes: state.minutes,
      seconds: state.seconds,
      isRunning: false,
    );
  }

  // Reset the timer
  void reset() {
    stop();
    state = TimerState(
      minutes: 1,
      seconds: 0,
      isRunning: false,
    );
  }
}
