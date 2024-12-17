import 'package:flutter/material.dart';

class AppTheme {
  static const darkBackground = Colors.black;
  static const darkSurface = Color(0xFF121212);
  static const accentBlue = Color(0xFF2C3E50);
  static const accentPurple = Color(0xFF2C2C4C);

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
      ),
    );
  }
}
