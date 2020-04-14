import 'package:flutter_firebase/shared/validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Empty email returns error string', () {
    var result = EmailFieldValidator.validate('');
    expect(result, 'Enter an email');
  });

  test('Valid email returns null', () {
    var result = EmailFieldValidator.validate('test@otterman.dev');
    expect(result, null);
  });

  // test('Invalid email returns error string', () {
  //   var result = EmailFieldValidator.validate('test');
  //   expect(result, 'Please enter a valid email');
  // });

  test('Empty password returns error string', () {
    var result = PasswordFieldValidator.validate('');
    expect(result, 'Password must be 6+ characters');
  });

  test('Short password returns error string', () {
    var result = PasswordFieldValidator.validate('pass');
    expect(result, 'Password must be 6+ characters');
  });

  test('Valid password returns null', () {
    var result = PasswordFieldValidator.validate('password1234');
    expect(result, null);
  });
}
