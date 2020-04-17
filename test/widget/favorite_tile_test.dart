import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/screens/home/favorite_tile.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements AuthService {}

void main() {
  testWidgets('Favorite tile', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: FavoriteTile(
          favorite: Favorite(
            name: 'Pizza',
            foodType: 'Takeout',
            userId: 'fakeId',
          ),
        ),
      ),
    ));
    expect(find.text('Pizza'), findsOneWidget);
    expect(find.text('Takeout'), findsOneWidget);
    expect(find.text('Remove'), findsOneWidget);

    // Need to figure out how to be more specific in looking for widgets
    // WidgetPredicate removeButtonPredicate =
    //     (Widget widget) => widget is ListTile;
    // expect(find.byWidgetPredicate(removeButtonPredicate), findsOneWidget);
  });
}
