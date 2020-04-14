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
