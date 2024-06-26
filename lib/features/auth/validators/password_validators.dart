class PasswordValidator {

  static PasswordValidationError? getValidationError(String? password) {
    if (password == null) return null;
    if (password.isEmpty) return PasswordValidationError.empty;
    if (password.contains(' ')) {
      return PasswordValidationError.containsSpace;
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return PasswordValidationError.noLowercase;
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return PasswordValidationError.noUppercase;
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return PasswordValidationError.noDigit;
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return PasswordValidationError.noSpecialChar;
    }
    if (password.length < 8) {
      return PasswordValidationError.tooShort;
    }
    return null;
  }

  static bool isValid(String? password) {
    if (password == null) return false;
    return getValidationError(password) == null;
  }
}

enum PasswordValidationError {
  empty,
  containsSpace,
  noDigit,
  noUppercase,
  noLowercase,
  noSpecialChar,
  tooShort;

  String getErrorText() {
    switch (this) {
      case PasswordValidationError.empty:
        return 'Password Field must not be empty!';
      case PasswordValidationError.containsSpace:
        return 'Password must not contain space!';
      case PasswordValidationError.noDigit:
        return 'Password must contain a digit!';
      case PasswordValidationError.noUppercase:
        return 'Password must contain a uppercase letter';
      case PasswordValidationError.noLowercase:
        return 'Password must contain a lowercase letter';
      case PasswordValidationError.noSpecialChar:
        return 'Password must contain a special character';
      case PasswordValidationError.tooShort:
        return 'Password must be 8 character long';
      default:
        return '';
    }
  }
}
