import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PrefKey {
  static const user = 'user';
  static const token = 'token';
}


class AppPreference {
  static late SharedPreferences _prefs;

  static Future initMySharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void clearSharedPreferences() {
    _prefs.clear();
    AppPreference.setBoolean(PrefKey.user, value: true);
    return;
  }

  static void removeSharedPreference(String key){
    _prefs.remove(key);
  }

  static Future setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String getString(String key) {
    final String? value = _prefs.getString(key);
    return value ?? "";
  }

  static Future setBoolean(String key, {required bool value}) async {
    await _prefs.setBool(key, value);
  }

  static bool getBoolean(String key) {
    final bool? value = _prefs.getBool(key);
    return value ?? false;
  }

  /// DOUBLE
  static Future setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  static double getDouble(String key) {
    final double? value = _prefs.getDouble(key);
    return value ?? 0.0;
  }

  static Future setLong(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  static double getLong(String key) {
    final double? value = _prefs.getDouble(key);
    return value ?? 0.0;
  }

  static Future setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static int getInt(String key) {
    final int? value = _prefs.getInt(key);
    return value ?? 0;
  }
}

