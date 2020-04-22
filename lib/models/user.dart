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

  factory UserData.fromMap(Map<String, dynamic> userMap) {
    List<dynamic> favoritesList = userMap['favorites'];
    return UserData(
      name: userMap['name'],
      uid: userMap['uid'],
      favorites: favoritesList.map((favoriteMap) {
        return Favorite(
          name: favoriteMap['name'],
          foodType: favoriteMap['foodType'],
        );
      }).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    var userMap = {
      'uid': uid,
      'name': name,
      'favorites': favorites.map((fav) {
        return {
          'name': fav.name,
          'foodType': fav.foodType,
        };
      }).toList(),
    };
    return userMap;
  }
}
