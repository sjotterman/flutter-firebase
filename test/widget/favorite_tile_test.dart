import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/home/add_favorite_form.dart';
import 'package:flutter_firebase/screens/home/favorite_tile.dart';
import 'package:flutter_firebase/screens/wrapper.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase/main.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements AuthService {}

class MockDBService extends Mock implements DatabaseService {}

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
  });
}
