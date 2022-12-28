import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _iconColor = Color(0xFFE44332);
  static const Color _lightPrimaryColor = Color(0xFFE44332);
  static const Color _lightSecondaryColor = Color(0xFFE44332);
  static const Color _backgroundColor = Colors.white;
  static const Color _colorText = Color(0XFF575767);

  static final ThemeData lightTheme = ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(),
      backgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: _lightPrimaryColor,
        secondary: _lightSecondaryColor,
      ),
      iconTheme: const IconThemeData(
        color: _iconColor,
      ),
      fontFamily: "inter",
      dividerTheme: const DividerThemeData(color: _colorText));

  static Color get backgroundColor => _backgroundColor;

  static Color get iconColor => _iconColor;

  static Color get colorText => _colorText;

  static Color get lightPrimaryColor => _lightPrimaryColor;
}
