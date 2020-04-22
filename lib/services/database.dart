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
    var userSnapshot = await userCollection.document(uid).get();
    var data = userSnapshot.data;
    data['name'] = name;
    return await userCollection.document(uid).updateData(data);
  }

  Future createUserWithEmail(String name) async {
    return await userCollection
        .document(uid)
        .setData({'name': name, 'items': []});
  }

  Future updateFavorite(String name, String foodType) async {
    var userSnapshot = await userCollection.document(uid).get();
    var data = userSnapshot.data;
    data['items'].add({
      'name': name,
      'foodType': foodType,
    });
    return await userCollection.document(uid).updateData(data);
  }

  Future deleteFavorite(Favorite favorite) async {
    var userSnapshot = await userCollection.document(uid).get();
    var data = userSnapshot.data;
    data['items'] = data['items'].where((item) {
      return item['name'] != favorite.name;
    }).toList();
    return await userCollection.document(uid).updateData(data);
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
