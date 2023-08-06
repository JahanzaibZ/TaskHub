import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static const _lightColor = Color.fromARGB(255, 240, 240, 240);
  static const _darkColor = Color.fromARGB(255, 25, 25, 25);

  static ThemeData appTheme({bool isDark = false}) {
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.ubuntuTextTheme().apply(
        bodyColor: isDark ? _lightColor : _darkColor,
        displayColor: isDark ? _lightColor : _darkColor,
      ),
      colorScheme: isDark ? _darkColorScheme() : _lightColorScheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 50),
          backgroundColor: isDark
              ? _lightColorScheme().primary
              : _lightColorScheme().primary,
          foregroundColor: isDark
              ? _lightColorScheme().onPrimary
              : _lightColorScheme().onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  static ColorScheme _lightColorScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 200, 0, 180),
      onPrimary: _lightColor,
      secondary: Colors.purple,
      onSecondary: _lightColor,
      error: Colors.red,
      onError: _lightColor,
      background: _lightColor,
      onBackground: _darkColor,
      surface: _lightColor,
      onSurface: _darkColor,
    );
  }

  static ColorScheme _darkColorScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 200, 0, 180),
      onPrimary: _lightColor,
      secondary: Colors.purple,
      onSecondary: _lightColor,
      error: Colors.red,
      onError: _lightColor,
      background: _darkColor,
      onBackground: _lightColor,
      surface: _darkColor,
      onSurface: _lightColor,
    );
  }
}
