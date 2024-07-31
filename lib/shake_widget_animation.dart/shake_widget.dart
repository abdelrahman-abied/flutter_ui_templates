import 'package:flutter/material.dart';
import 'package:flutter_ui_template/shake_widget_animation.dart/custom_sine_curve.dart';

import 'custom_animation_controller.dart';

// TODO 4. Create a custom CurvedAnimation
class ShakeWidget extends StatefulWidget {
  final Widget child;
  final Duration shakeDuration;
  final int shakeCount;
  final double shakeOffset;
  ShakeWidget({
    super.key,
    required this.child,
    this.shakeDuration = const Duration(milliseconds: 300),
    this.shakeCount = 3,
    required this.shakeOffset,
  });

  @override
  State<ShakeWidget> createState() => ShakeWidgetState(shakeDuration);
}

class ShakeWidgetState extends AnimationControllerState<ShakeWidget> {
  ShakeWidgetState(super.animationDuration);
  // 1. create a Tween

  late final Animation<double> _sineAnimation = Tween(
    begin: 0.0,
    end: 1.0,
    // 2. animate it with a CurvedAnimation
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: SineCurve(
        // 3. use our SineCurve

        count: widget.shakeCount.toDouble(),
      ),
    ),
  );

//TODO 5. Use the animation with AnimatedBuilder and Transform.translate
  @override
  Widget build(BuildContext context) {
    // 1. return an AnimatedBuilder
    return AnimatedBuilder(
      // 2. pass our custom animation as an argument
      animation: _sineAnimation,
      // 3. optimization: pass the given child as an argument
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          // 4. apply a translation as a function of the animation value
          offset: Offset(_sineAnimation.value * widget.shakeOffset, 0),
          // 5. use the child widget
          child: child,
        );
      },
    );
  }

  // note: this method is public

  void shake() {
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
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }
}
