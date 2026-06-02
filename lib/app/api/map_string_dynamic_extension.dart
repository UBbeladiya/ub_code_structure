import 'dart:convert';

extension SafeAccessStringMap on Map<String, dynamic> {
  String safe(String key, {String defaultValue = ''}) {
    if (this[key] != null) {
      final stringValue = this[key].toString();
      if (stringValue.isEmpty || stringValue == 'null') {
        return defaultValue;
      }
      return stringValue;
    }
    return defaultValue;
  }

  String? safeNullable(String key, {String? defaultValue}) {
    if (this[key] != null) {
      final stringValue = this[key].toString();
      return stringValue.isEmpty || stringValue == 'null' ? defaultValue : stringValue;
    }
    return defaultValue;
  }

  List<String> safeListOfString(String key, {List<String> defaultValue = const []}) {
    try {
      if (this[key] != null) {
        if (this[key] is List<dynamic>) {
          return List<String>.from(this[key] ?? defaultValue);
        }
        if (this[key] is String) {
          final decodedData = json.decode(this[key]);
          if (decodedData is List<dynamic>) {
            return List<String>.from(decodedData);
          }
        }
      }

      return defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  int safeInt(String key, {int defaultValue = 0}) {
    return safe(key).toInt(defaultValue: defaultValue);
  }

  int? safeNullableInt(String key, {int? defaultValue}) {
    return safe(key).toNullableInt(defaultValue: defaultValue);
  }

  //temp
  double safeDouble(String key, {double defaultValue = 0.0}) {
    return safe(key).toDouble(defaultValue: defaultValue);
  }

  bool safeBool(String key) {
    final requiredValues = ['true', '1', 'yes', 'enable', 'on', 'active'];
    final value = safe(key);
    return requiredValues.contains(value.toLowerCase());
  }

  Map<String, dynamic> safeMap(String key) {
    if (this[key] is Map<String, dynamic>) {
      return this[key] as Map<String, dynamic>? ?? {};
    }
    return {};
  }

  List<dynamic> safeList(String key) {
    if (this[key] is List<dynamic>) {
      return this[key] as List<dynamic>? ?? [];
    }
    return [];
  }

  bool isValidMap(dynamic key) {
    final value = this[key];

    if (value != null && value is Map<String, dynamic> && value.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isValidList(dynamic key) {
    final value = this[key];

    if (value != null && value is List<dynamic> && value.isNotEmpty) {
      return true;
    }
    return false;
  }
}

extension StringExtension on String {
  int toInt({int defaultValue = 0}) {
    return int.tryParse(this) ?? defaultValue;
  }

  int? toNullableInt({int? defaultValue}) {
    return int.tryParse(this) ?? defaultValue;
  }

  double toDouble({double defaultValue = 0}) {
    return double.tryParse(this) ?? defaultValue;
  }

  double? toNullableDouble({double? defaultValue}) {
    return double.tryParse(this) ?? defaultValue;
  }
}
