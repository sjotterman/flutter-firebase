import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/home/favorite_tile.dart';
import 'package:flutter_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class FavoritesList extends StatefulWidget {
  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context) ?? null;
    if (userData == null) {
      return Loading();
    }
    final favorites = userData.favorites;
    return ListView.builder(
      // scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return FavoriteTile(favorite: favorites[index]);
      },
    );
  }
}
