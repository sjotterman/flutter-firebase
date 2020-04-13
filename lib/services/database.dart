import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/models/user.dart';

class DatabaseService {
  // collection reference
  final String uid;

  DatabaseService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  final CollectionReference favoriteCollection =
      Firestore.instance.collection('favorites');

  Future updateUserData(String name) async {
    return await userCollection.document(uid).setData({'name': name});
  }

  Future createUserWithEmail(String name) async {
    return await userCollection
        .document(uid)
        .setData({'name': name, 'items': []});
  }

  Future updateFavorite(String name, String foodType) async {
    var userData = await userCollection.document(uid).get();
    var items = userData.data['items'];
    items.add({
      'name': name,
      'foodType': foodType,
    });
    return await userCollection.document(uid).setData({'items': items});
  }

  Future deleteFavorite(Favorite favorite) async {
    var userData = await userCollection.document(uid).get();
    var items = userData.data['items'];
    items = items.where((item) {
      return item['name'] != favorite.name;
    }).toList();
    return await userCollection.document(uid).setData({'items': items});
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    var items = snapshot.data['items'];
    List<Favorite> favorites = List();
    items.forEach((item) {
      Favorite newFavorite = Favorite(
        userId: uid,
        foodType: item['foodType'],
        name: item['name'],
      );
      favorites.add(newFavorite);
    });
    return UserData(
      uid: uid,
      favorites: favorites,
    );
  }

  FavoriteData _favoriteDataFromSnapshot(DocumentSnapshot snapshot) {
    var items = snapshot.data['items'];
    List<Favorite> favorites = List();
    items.forEach((item) {
      Favorite newFavorite = Favorite(
        userId: uid,
        foodType: item['foodType'],
        name: item['name'],
      );
      favorites.add(newFavorite);
    });
    return FavoriteData(favorites: favorites);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<FavoriteData> get favoriteData {
    return favoriteCollection
        .document(uid)
        .snapshots()
        .map(_favoriteDataFromSnapshot);
  }
}
