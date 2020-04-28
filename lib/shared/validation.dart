class EmailFieldValidator {
  static String validate(String value) {
    bool isValid = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value);
    return isValid ? null : 'Enter an email';
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.length < 6 ? 'Password must be 6+ characters' : null;
  }
}

class SelectionCodeValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Enter a code';
    }
    bool isValid = RegExp(r"^[A-Za-z]{4}$").hasMatch(value);
    return isValid ? null : 'Code must be exactly 4 letters';
  }
}
