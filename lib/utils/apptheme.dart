import 'package:flutter/material.dart';

class AppTheme {

  AppTheme._();
  static const Color _iconColor = Color(0xFFE44332);
  static const Color _lightPrimaryColor = Color(0xFFE44332);
  static const Color _lightPrimaryVariantColor = Color(0xFFE44332);
  static const Color _lightSecondaryColor = Color(0xFFE44332);
  static const Color _lightOnPrimaryColor = Colors.black;
  static const Color _backgroundColor =  Colors.white;

  static const Color _darkPrimaryColor = Colors.white24;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(
      ),
      backgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: _lightPrimaryColor,
        secondary: _lightSecondaryColor,
        onPrimary: _darkSecondaryColor,
      ),
      iconTheme: const IconThemeData(
        color: _iconColor,
      ),
      fontFamily: "inter",
      textTheme: _lightTextTheme,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => const Color(0XFF575767)),
        overlayColor:MaterialStateColor.resolveWith((states) => const Color(0XFFDADADA))
      ),
      dividerTheme: const DividerThemeData(color: Color(0XFF575767)));

  static Color get backgroundColor => _backgroundColor;

  static Color get iconColor => _iconColor;


  static Color get lightPrimaryColor => _lightPrimaryColor;

  /*  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: _darkPrimaryVariantColor,
      appBarTheme: const AppBarTheme(
        color: _darkPrimaryVariantColor,
        iconTheme: IconThemeData(color: _darkOnPrimaryColor),
      ),
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimaryColor,
        primaryVariant: _darkPrimaryVariantColor,
        secondary: _darkSecondaryColor,
        onPrimary: _darkOnPrimaryColor,
        background: Colors.white12,
      ),
      iconTheme: IconThemeData(
        color: _iconColor,
      ),
      textTheme: _darkTextTheme,
      dividerTheme: const DividerThemeData(color: Colors.black));*/

  static const TextTheme _lightTextTheme = TextTheme(
    headline1: _lightScreenHeading1TextStyle,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkScreenHeading1TextStyle,
  );

  static const TextStyle _lightScreenHeading1TextStyle = TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static final TextStyle _darkScreenHeading1TextStyle =
  _lightScreenHeading1TextStyle.copyWith(color: _darkOnPrimaryColor);
}
