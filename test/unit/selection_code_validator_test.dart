import 'package:flutter_firebase/shared/validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Empty code returns error string', () {
    var result = SelectionCodeValidator.validate('');
    expect(result, 'Enter a code');
  });

  test('Valid uppercase code returns null', () {
    var result = SelectionCodeValidator.validate('ABCD');
    expect(result, null);
  });

  test('Valid lowercase code returns null', () {
    var result = SelectionCodeValidator.validate('abcd');
    expect(result, null);
  });

  test('Valid mixed case code returns null', () {
    var result = SelectionCodeValidator.validate('abCD');
    expect(result, null);
  });
  test('Numbers return error', () {
    var result = SelectionCodeValidator.validate('1234');
    expect(result, 'Code must be exactly 4 letters');
  });
}
