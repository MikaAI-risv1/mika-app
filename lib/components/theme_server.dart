import 'package:flutter/material.dart';

class AppTheme {
  static const darkBlue = Color(0xFF2C3E50);
  static const darkPurple = Color(0xFF4A148C);
  static const accentBlue = Color(0xFF3498DB);
  static const accentPurple = Color(0xFF9B59B6);

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      cardColor: darkBlue.withOpacity(0.3),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkBlue,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
