import 'dart:math';
import 'package:flutter/material.dart';

// TODO 3. Create a custom ShakeWidget
// 1. custom Curve subclass
class SineCurve extends Curve {
  final double count;
  SineCurve({this.count = 3});

  // 2. override transformInternal() method
  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t);
  }
}
