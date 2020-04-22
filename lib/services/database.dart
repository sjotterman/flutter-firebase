import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/models/session.dart';
import 'package:flutter_firebase/models/user.dart';

class DatabaseService {
  // collection reference
  final String uid;

  DatabaseService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  final CollectionReference favoriteCollection =
      Firestore.instance.collection('favorites');

  final CollectionReference sessionCollection =
      Firestore.instance.collection('sessions');

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
    var userId = snapshot.documentID;
    List<Favorite> favorites = List();
    items.forEach((item) {
      Favorite newFavorite = Favorite(
        userId: userId,
        foodType: item['foodType'],
        name: item['name'],
      );
      favorites.add(newFavorite);
    });
    return UserData(
      uid: userId,
      name: snapshot.data['name'],
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

  Future<UserData> getUserDataById(String userId) async {
    var results = await userCollection.document(userId).get();
    return _userDataFromSnapshot(results);
  }

  Future createSession() async {
    UserData creator = await getUserDataById(uid);
    // TODO: make this code random
    // TODO: make sure the code isn't reused
    // TODO: make sure the session has an expiration
    String sessionCode = 'ABCD';
    var creatorData = creator.toMap();
    return await sessionCollection.document().setData({
      'creatorId': uid,
      'sessionCode': sessionCode,
      'members': [creatorData]
    });
  }

  Session _sessionDataFromSnapshot(QuerySnapshot snapshot) {
    if (snapshot.documents.length == 0) {
      return null;
    }
    var firstDocument = snapshot.documents.first;
    var data = firstDocument.data;
    var membersMapList = data['members'];
    List<UserData> members = [];
    membersMapList.forEach((member) {
      members.add(UserData.fromMap(member));
    });
    return Session(
        id: firstDocument.documentID,
        sessionCode: data['sessionCode'],
        members: members);
  }

  Stream<Session> get createdSession {
    var results = sessionCollection
        .where('creatorId', isEqualTo: uid)
        .snapshots()
        .map(_sessionDataFromSnapshot);
    return results;
  }
}
