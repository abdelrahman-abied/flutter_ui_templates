import 'package:flutter/material.dart';

class AppColorTheme extends ThemeExtension<AppColorTheme> {
  final Color primaryColor;

  final Color secondaryColor;

  AppColorTheme({
    this.primaryColor = Colors.green,
    this.secondaryColor = Colors.pink,
  });

  // create  app color theme from dark color scheme
  factory AppColorTheme.dark() {
    return AppColorTheme(
      primaryColor: Colors.blue,
      secondaryColor: Colors.red,
    );
  }

  @override
  ThemeExtension<AppColorTheme> copyWith({
    Color? appPrimaryColor,
    Color? appSecondaryColor,
  }) {
    return AppColorTheme(
      primaryColor: appPrimaryColor ?? primaryColor,
      secondaryColor: appSecondaryColor ?? secondaryColor,
    );
  }

  /// lerp: This method is used for theme animations. When switching between themes,
  /// it enables smooth transitions between color values.
  @override
  ThemeExtension<AppColorTheme> lerp(
    covariant ThemeExtension<AppColorTheme>? other,
    double t,
  ) {
    if (other == null) {
      return this;
    }
    return AppColorTheme();
  }
}
