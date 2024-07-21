import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_template/main.dart';
import 'package:flutter_ui_template/shared_timer/seconds.dart';

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
final timerProvider = StateNotifierProvider.autoDispose<TimerNotifier, TimerState>((ref) {
  return TimerNotifier(
    initialMinutes: 10,
    initialSeconds: 0,
  )..start();
});

// Define a notifier class to manage the timer logic
class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier({required int initialMinutes, required int initialSeconds})
      : super(TimerState(
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
        // Navigate to home screen
        navigatorKey.currentState?.popUntil((route) => route.isFirst);
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
      minutes: 10,
      seconds: 0,
      isRunning: false,
    );
  }
}

// Widget to display the timer
class SharedTimerWidget extends ConsumerWidget {
  const SharedTimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${timerState.minutes.toString().padLeft(2, '0')}:${timerState.seconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 58),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => ref.read(timerProvider.notifier).start(),
                  child: const Text('Start'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => ref.read(timerProvider.notifier).stop(),
                  child: const Text('Stop'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => ref.read(timerProvider.notifier).reset(),
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondTimer(),
                      ),
                    );
                  },
                  child: const Text('Home'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
