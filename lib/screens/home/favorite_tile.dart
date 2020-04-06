import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/favorite.dart';

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
          subtitle: Text('Subtitle'),
        ),
      ),
    );
  }
}
