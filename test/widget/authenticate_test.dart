import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/screens/authenticate/authenticate.dart';
import 'package:flutter_firebase/screens/wrapper.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase/main.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements AuthService {}

void main() {
  testWidgets('View sign-in when not logged in', (WidgetTester tester) async {
    when(MockAuth().user).thenAnswer((_) => Stream.fromIterable(null));
    Widget wrappedWidget = StreamProvider<User>.value(
      value: MockAuth().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
    await tester.pumpWidget(wrappedWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign In'), findsNWidgets(2));
  });

  // testWidgets('View home when logged in', (WidgetTester tester) async {
  //   when(MockAuth().user)
  //       .thenAnswer((_) => Stream.fromIterable([User(uid: '123')]));
  //   Widget wrappedWidget = MultiProvider(
  //     providers: [
  //       StreamProvider<User>.value(
  //         value: MockAuth().user,
  //       ),
  //     ],
  //     child: MaterialApp(
  //       home: MyApp(),
  //     ),
  //   );
  //   await tester.pumpWidget(wrappedWidget);
  //   tester.takeException();
  //   await tester.pumpAndSettle();
  //   tester.takeException();
  //   expect(find.text('log out'), findsOneWidget);
  //   expect(find.text('settings'), findsOneWidget);
  // });

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
