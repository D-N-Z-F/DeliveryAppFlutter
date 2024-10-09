class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required.";
    final emailRegex = RegExp(r'^[a-zA-Z0-9]{3,}@[a-zA-Z0-9]+\.[a-zA-Z]{3}$');
    if (!emailRegex.hasMatch(value)) return "Invalid email address.";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required.";
    if (value.length < 6) return "Password must be at least 6 characters long";
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter.";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least one special character.";
    }
    return null;
  }
}
