import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData.light().copyWith(
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFD2E5F0),
      ),
      scaffoldBackgroundColor: Color(0xFFD2E5F0),
      colorScheme: ColorScheme.light().copyWith(
          primaryContainer: Colors.blueAccent,
          secondary: Colors.blueAccent[700],
          onSecondary: Colors.blue[400]),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[800],
      ),
      scaffoldBackgroundColor: Colors.grey[800],
      useMaterial3: true,
      colorScheme: ColorScheme.dark().copyWith(
        primary: Colors.blueAccent,
        primaryContainer: Colors.blueAccent,
        secondary: Colors.blueAccent[700],
        onSecondary: Colors.grey[900],
      ),
    );
  }
}
