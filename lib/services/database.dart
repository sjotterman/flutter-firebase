import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/brew.dart';

class DatabaseService {
  // collection reference
  final String uid;

  DatabaseService({this.uid});
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
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

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }
}
