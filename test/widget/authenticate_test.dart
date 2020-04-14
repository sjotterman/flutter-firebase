import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase/main.dart';

void main() {
  testWidgets('Switch from sign in to register', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Sign In'), findsNWidgets(2));

    // Tap the register button
    await tester.tap(find.text('Register'));
    await tester.pump();

    expect(find.text('Register'), findsOneWidget);
    // Should be consistent between register and sign up
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
