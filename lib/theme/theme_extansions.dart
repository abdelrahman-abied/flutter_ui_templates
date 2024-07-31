import 'package:flutter/material.dart';
import 'package:flutter_ui_template/theme/app_color_theme.dart';
import 'package:flutter_ui_template/theme/app_gradient_theme.dart';
import 'package:flutter_ui_template/theme/app_shadow_theme.dart';

extension ThemeDataExtension on ThemeData {
  AppColorTheme get colorTheme => extension<AppColorTheme>() ?? AppColorTheme();
  
  AppShadowTheme get appShadowTheme => extension<AppShadowTheme>() ?? AppShadowTheme();

  AppGradientTheme get appGradientTheme =>
      extension<AppGradientTheme>() ?? AppGradientTheme.generate(colorScheme: colorScheme);
}
