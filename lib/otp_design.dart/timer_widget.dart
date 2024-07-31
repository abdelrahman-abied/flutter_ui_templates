import 'package:flutter/material.dart';

import '../shake_widget_animation.dart/custom_animation_controller.dart';

class TimerWidget extends StatefulWidget {
  final int timeInSeconds;
  TimerWidget({super.key, this.timeInSeconds = 60});

  @override
  TimerWidgetState createState() =>
      TimerWidgetState(Duration(seconds: timeInSeconds), timeInSeconds);
}

class TimerWidgetState extends AnimationControllerState {
  final int timeInSeconds;
  late Animation<double> animation = Tween(
    begin: timeInSeconds.toDouble(),
    end: 0.0,
  ).animate(animationController);

  TimerWidgetState(super.animationDuration, this.timeInSeconds);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Text(timerString);
      },
    );
  }

  String get timerString {
    return (formatedTime(timeInSecond: animation.value.toInt()));
  }

  void startTimer() {
    animationController.forward();
  }

// TODO 6. Add a status listener to reset the animation when complete
  @override
  void initState() {
    super.initState();
    // 1. register a status listener
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    // 2. dispose it when done
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    // 3. reset animationController when the animation is complete
    print(formatedTime(timeInSecond: animation.value.toInt()));
    if (animationController.isCompleted) {
      animationController.stop();
      animationController.reset();
    } else if (animationController.isDismissed) {
      animationController.stop();
    }
  }

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
