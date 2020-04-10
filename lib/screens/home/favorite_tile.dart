import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/services/database.dart';

class FavoriteTile extends StatelessWidget {
  final Favorite favorite;

  FavoriteTile({this.favorite});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(favorite.name),
          trailing: FlatButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            icon: Icon(Icons.remove_circle),
            label: Text('Remove'),
            onPressed: () async {
              try {
                await DatabaseService(uid: favorite.userId)
                    .deleteFavorite(favorite);
              } catch (e) {
                print(e.toString());
              }
            },
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
