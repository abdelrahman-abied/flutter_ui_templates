import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_template/shared_timer/shared_downtimer.dart';

class SecondTimer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);

    // Format the remaining time
    final formattedTime =
        Duration(seconds: timerState.seconds).toString().split('.').first.padLeft(8, '0');
    return Scaffold(
      appBar: AppBar(),
      body: Text(
        '${timerState.minutes.toString().padLeft(2, '0')}:${timerState.seconds.toString().padLeft(2, '0')}',
        style: const TextStyle(fontSize: 48),
      ),
    );
  }
}
