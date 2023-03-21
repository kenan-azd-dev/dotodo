import 'package:dotodo/utils/constants.dart';
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
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ThemeData.light().colorScheme.background,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(
              color: ThemeData.light().colorScheme.error, width: 2.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
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
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ThemeData.light().colorScheme.background,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(
              color: ThemeData.light().colorScheme.error, width: 2.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
      ),
    );
  }
}
