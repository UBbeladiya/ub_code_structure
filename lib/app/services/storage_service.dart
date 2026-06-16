import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

/// Canonical preference keys used by [AppPreference].
class PrefKey {
  /// Stores whether user data is available in local storage.
  static const user = 'user';

  /// Stores an auth/session token.
  static const token = 'token';
}

/// Shared preferences wrapper used for simple key-value persistence.
class AppPreference {
  static late SharedPreferences _prefs;

  /// Initializes the singleton [SharedPreferences] instance.
  static Future initMySharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Clears all keys and resets the [PrefKey.user] flag.
  static void clearSharedPreferences() {
    _prefs.clear();
    AppPreference.setBoolean(PrefKey.user, value: true);
    return;
  }

  /// Removes a single value by [key].
  static void removeSharedPreference(String key){
    _prefs.remove(key);
  }

  /// Saves a string [value] for [key].
  static Future setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  /// Reads a string for [key] or returns an empty value.
  static String getString(String key) {
    final String? value = _prefs.getString(key);
    return value ?? "";
  }

  /// Saves a boolean [value] for [key].
  static Future setBoolean(String key, {required bool value}) async {
    await _prefs.setBool(key, value);
  }

  /// Reads a boolean for [key] or returns `false`.
  static bool getBoolean(String key) {
    final bool? value = _prefs.getBool(key);
    return value ?? false;
  }

  /// Saves a double [value] for [key].
  static Future setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  /// Reads a double for [key] or returns `0.0`.
  static double getDouble(String key) {
    final double? value = _prefs.getDouble(key);
    return value ?? 0.0;
  }

  /// Saves a large numeric value as double for [key].
  static Future setLong(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  /// Reads a large numeric value as double for [key].
  static double getLong(String key) {
    final double? value = _prefs.getDouble(key);
    return value ?? 0.0;
  }

  /// Saves an integer [value] for [key].
  static Future setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  /// Reads an integer for [key] or returns `0`.
  static int getInt(String key) {
    final int? value = _prefs.getInt(key);
    return value ?? 0;
  }
}
