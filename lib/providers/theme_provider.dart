import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeProvider with ChangeNotifier {

  ThemeModeProvider({
    required SharedPreferences prefs,
  }) : _prefs = prefs {
    _init();
  }
  ThemeMode themeMode = ThemeMode.system;
  final SharedPreferences _prefs;
  String _key = 'theme';

  Future<void> mode(ThemeMode value) async {
    themeMode = value;
    notifyListeners();
    await saveTheme();
  }

  Future<void> saveTheme() async {
    String value;
    switch (themeMode) {
      case ThemeMode.dark:
        value = 'dark';
        break;
      case ThemeMode.light:
        value = 'light';
        break;
      case ThemeMode.system:
        value = 'system';
    }
    _prefs.setString(_key, value);
  }

  void _init() {
    final currentTheme = _prefs.getString(_key);
    switch (currentTheme) {
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'system':
        themeMode = ThemeMode.system;
    }
    notifyListeners();
  }


}
