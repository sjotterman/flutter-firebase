import 'package:flutter/material.dart';
import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/screens/selection/create_group.dart';
import 'package:flutter_firebase/screens/selection/display_selection.dart';
import 'package:flutter_firebase/screens/selection/join_group.dart';
import 'package:flutter_firebase/screens/selection/join_or_create_group.dart';
import 'package:flutter_firebase/screens/selection/selection.dart';
import 'package:flutter_firebase/screens/selection/solo_or_group.dart';
import 'package:flutter_firebase/screens/wrapper.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase/models/user.dart';

import 'models/session.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().user,
        ),
        ChangeNotifierProvider(
          create: (context) => SelectionData(),
        )
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<UserData>.value(
          value:
              (user != null) ? DatabaseService(uid: user.uid).userData : null,
        ),
        StreamProvider<Session>.value(
          value: (user != null)
              ? DatabaseService(uid: user.uid).createdSession
              : null,
        )
      ],
      child: MaterialApp(
        title: 'Meal Picker',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          accentColor: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/selection': (context) => Selection(),
          '/soloOrGroup': (context) => SoloOrGroupSelection(),
          '/joinOrCreateGroup': (context) => JoinOrCreateGroup(),
          '/joinGroup': (context) => JoinGroup(),
          '/createGroup': (context) => CreateGroup(),
          '/displaySelection': (context) => DisplaySelection(),
        },
      ),
    );
  }
}
