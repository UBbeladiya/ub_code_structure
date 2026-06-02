

/// Enum for validator types.
enum ValidatorType { email, password, name, mobile }

/// Validators for common form fields.
class Validators {
  /// Calls the appropriate validator based on [type].
  static String? callFunction(ValidatorType type, String? value) {
    switch (type) {
      case ValidatorType.email:
        return validateEmail(value);
      case ValidatorType.password:
        return validatePassword(value);
      case ValidatorType.name:
        return validateName(value);
      case ValidatorType.mobile:
        return validateMobile(value);
    }
  }

  /// Validates an email address. Returns null if valid, otherwise an error message.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}\$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  /// Validates a password. Returns null if valid, otherwise an error message.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  /// Validates a name. Returns null if valid, otherwise an error message.
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Name is required';
    if (value.length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  /// Validates a 10-digit mobile number. Returns null if valid, otherwise an error message.
  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) return 'Mobile number is required';
    final mobileRegex = RegExp(r'^\d{10}\$');
    if (!mobileRegex.hasMatch(value)) return 'Enter a valid 10-digit mobile number';
    return null;
  }
}
