import 'package:flutter/material.dart';

class AppGradientTheme extends ThemeExtension<AppGradientTheme> {
  final Gradient backgroundGradient;

  AppGradientTheme({
    required this.backgroundGradient,
  });
  // Here we can pass colorScheme to use color from color scheme only
  factory AppGradientTheme.generate({required ColorScheme colorScheme}) {
    return AppGradientTheme(
      backgroundGradient: LinearGradient(
        stops: const [0.1, 0.2, 0.9, 0.9, 0.95, 1],
        colors: [
          colorScheme.surfaceTint, // <-- Here
          colorScheme.surfaceTint,
          colorScheme.onInverseSurface,
          colorScheme.onInverseSurface,
          colorScheme.onInverseSurface,
          colorScheme.onInverseSurface,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    );
  }
  
  @override
  ThemeExtension<AppGradientTheme> copyWith() {
    return AppGradientTheme(
      backgroundGradient: backgroundGradient,
    );
  }
  
  @override
  ThemeExtension<AppGradientTheme> lerp(covariant ThemeExtension<AppGradientTheme>? other, double t) {
    if (other == null) {
      return this;
    }
    return AppGradientTheme(
     backgroundGradient:  LinearGradient(colors: []),
    );
  }

 
}
