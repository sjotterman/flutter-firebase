import 'dart:io' show Platform;

import 'package:flutter_driver/flutter_driver.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart';

void main() {
  group('App', () {
    final eatSomethingFinder = find.text('What should I eat?');
    final emailFinder = find.byValueKey('email_field');
    final passwordFinder = find.byValueKey('password_field');
    final buttonFinder = find.byValueKey('sign_in_button');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test('sign in', () async {
      await driver.tap(emailFinder);
      String testEmail = Platform.environment['TEST_EMAIL'];
      String testPassword = Platform.environment['TEST_PASSWORD'];
      expect(testEmail != null, true, reason: 'TEST_EMAIL is null');
      expect(testPassword != null, true, reason: 'TEST_PASSWORD is null');
      await driver.enterText(testEmail);
      await driver.tap(passwordFinder);
      await driver.enterText(testPassword);
      await driver.tap(buttonFinder);
      await driver.waitFor(eatSomethingFinder);
      await driver.waitFor(find.byValueKey('favorites_overview'));
    });
  });
}
