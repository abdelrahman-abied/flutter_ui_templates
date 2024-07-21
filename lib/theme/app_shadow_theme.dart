import 'package:flutter/material.dart';

class AppShadowTheme extends ThemeExtension<AppShadowTheme> {
  final BoxShadow primaryShadow;
  // For Light Mode call AppShadowTheme()
  AppShadowTheme({
    this.primaryShadow = const BoxShadow(
      color: Color(0xFF6750A4),
      blurRadius: 10,
      spreadRadius: 10,
      offset: Offset(-10, 10),
      blurStyle: BlurStyle.outer,
    ),
  });
  // For dark Mode call AppShadowTheme.dark()
  factory AppShadowTheme.dark() {
    return AppShadowTheme(
      primaryShadow: const BoxShadow(
        color: Color(0xFF381E72),
        blurRadius: 10,
        spreadRadius: 10,
        offset: Offset(-10, 10),
        blurStyle: BlurStyle.outer,
      ),
    );
  }

  @override
  AppShadowTheme copyWith({
    BoxShadow? primaryShadow,
  }) {
    return AppShadowTheme(
      primaryShadow: primaryShadow ?? this.primaryShadow,
    );
  }

  @override
  ThemeExtension<AppShadowTheme> lerp(
    covariant ThemeExtension<AppShadowTheme>? other,
    double t,
  ) {
    if (other == null) {
      return this;
    }
    return AppShadowTheme();
  }
}
