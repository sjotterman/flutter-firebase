class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Enter an email' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.length < 6 ? 'Password must be 6+ characters' : null;
  }
}
