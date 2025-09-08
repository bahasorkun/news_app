import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  AppState._();
  static final AppState instance = AppState._();

  ThemeMode themeMode = ThemeMode.light;
  Locale? locale; // null => system

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final t = prefs.getString('themeMode');
    switch (t) {
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      case 'system':
        themeMode = ThemeMode.system;
        break;
      default:
        themeMode = ThemeMode.light;
    }
    final code = prefs.getString('locale');
    if (code != null && code.isNotEmpty) {
      locale = Locale(code);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final str = mode == ThemeMode.dark
        ? 'dark'
        : (mode == ThemeMode.system ? 'system' : 'light');
    await prefs.setString('themeMode', str);
  }

  Future<void> setLocale(Locale? loc) async {
    locale = loc;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    if (loc == null) {
      await prefs.remove('locale');
    } else {
      await prefs.setString('locale', loc.languageCode);
    }
  }
}
