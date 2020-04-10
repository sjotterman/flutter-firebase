import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/screens/home/add_favorite_form.dart';
import 'package:flutter_firebase/screens/home/favorites_list.dart';
import 'package:provider/provider.dart';

class FavoritesOverview extends StatelessWidget {
  const FavoritesOverview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteData = Provider.of<FavoriteData>(context) ?? null;
    final favorites = favoriteData != null ? favoriteData.favorites : [];
    void _showAddFavoritePanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: AddFavoriteForm(),
            );
          });
    }

    void _showRandomSelection(List favorites) {
      var rng = new Random();
      var randomIndex = rng.nextInt(favorites.length);
      var randomFavorite = favorites[randomIndex];
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Random selection'),
            content: Text(
                'Your random selection is: ${randomFavorite.name} (${randomFavorite.foodType})'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              )
            ],
          );
        },
      );
    }

    void _showNeedMoreFavoritesDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Need more favorites!'),
            content:
                Text('You need at least two favorites from which to pick!'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              )
            ],
          );
        },
      );
    }

    void _onChoiceButtonPress() {
      var numFavorites = favorites.length;
      if (numFavorites > 1) {
        _showRandomSelection(favorites);
      } else {
        _showNeedMoreFavoritesDialog();
      }
    }

    return Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage('assets/coffee_bg.png'), fit: BoxFit.cover),
        // ),
        child: Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          height: 60.0,
          minWidth: 190.0,
          onPressed: () => _onChoiceButtonPress(),
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('What should I eat?'),
        ),
        SizedBox(height: 20.0),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          height: 60.0,
          minWidth: 190.0,
          onPressed: () => _showAddFavoritePanel(),
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('Add favorite food'),
        ),
        Expanded(child: FavoritesList()),
      ],
    ));
  }
}
