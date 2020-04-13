import 'package:flutter_firebase/models/favorite.dart';

class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final List<Favorite> favorites;

  UserData({this.uid, this.name, this.favorites});
}
