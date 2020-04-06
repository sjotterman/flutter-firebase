import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/models/user.dart';

class DatabaseService {
  // collection reference
  final String uid;

  DatabaseService({this.uid});
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  final CollectionReference favoriteCollection =
      Firestore.instance.collection('favorites');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  Future updateFavorite(String name) async {
    var existingFavoriteData = await favoriteCollection.document(uid).get();
    var items = existingFavoriteData.data['items'];
    print(existingFavoriteData.data['items']);
    print(items.runtimeType);
    items.add({'name': name});
    return await favoriteCollection.document(uid).setData({'items': items});
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '0');
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  FavoriteData _favoriteDataFromSnapshot(DocumentSnapshot snapshot) {
    var items = snapshot.data['items'];
    List<Favorite> favorites = List();
    items.forEach((item) {
      Favorite newFavorite = Favorite(uid: uid, name: item['name']);
      favorites.add(newFavorite);
    });
    return FavoriteData(favorites: favorites);
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<FavoriteData> get favoriteData {
    var snapshots = favoriteCollection.document(uid).snapshots();
    print(snapshots);
    return favoriteCollection
        .document(uid)
        .snapshots()
        .map(_favoriteDataFromSnapshot);
  }
}
