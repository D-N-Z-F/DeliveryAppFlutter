class Validators {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return "Username is required.";
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Username must not contain any special characters.";
    }
    final lengthRegex = RegExp(r'^.{3,18}$');
    if (!lengthRegex.hasMatch(value)) {
      return "Username must be between 3 to 18 characters long.";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required.";
    final emailRegex = RegExp(r'^[a-zA-Z0-9]{3,}@[a-zA-Z0-9]+\.[a-zA-Z]{3}$');
    if (!emailRegex.hasMatch(value)) return "Invalid email address.";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required.";
    if (value.length < 6) return "Password must be at least 6 characters long.";
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter.";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number.";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least one special character.";
    }
    return null;
  }

  static String? validatePassword2(String? value, String? original) {
    if (value != original) return "Both passwords must match.";
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) return "Address shouldn't be empty.";
    return null;
  }
}
