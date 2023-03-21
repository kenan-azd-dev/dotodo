import 'package:dotodo/utils/theme.dart';
import 'package:flutter/material.dart';

class Utils {
  static String getMonthName(int monthNumber) {
    List<String> months = [
      "", // 0
      "Jan", // 1
      "Feb", // 2
      "Mar", // 3
      "Apr", // 4
      "May", // 5
      "Jun", // 6
      "Jul", // 7
      "Aug", // 8
      "Sep", // 9
      "Oct", // 10
      "Nov", // 11
      "Dec", // 12
    ];

    return months[monthNumber];
  }

  static ThemeData determineTheme(
    ThemeMode themeMode,
    BuildContext context,
  ) {
    if (themeMode == ThemeMode.dark) {
      return AppTheme.dark;
    } else if (themeMode == ThemeMode.light) {
      return AppTheme.light;
    } else {
      final platformBrightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window).platformBrightness;
      if (platformBrightness == Brightness.dark) {
        return AppTheme.dark;
      } else {
        return AppTheme.light;
      }
    }
  }
}
