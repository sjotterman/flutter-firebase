import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/screens/home/add_favorite_form.dart';
import 'package:flutter_firebase/screens/home/favorites_list.dart';
import 'package:flutter_firebase/screens/selection/large_custom_button.dart';
import 'package:provider/provider.dart';

class FavoritesOverview extends StatelessWidget {
  const FavoritesOverview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context) ?? null;
    final selectionData = Provider.of<SelectionData>(context);
    final favorites = userData != null ? userData.favorites : [];
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
        selectionData.setOptions(favorites);
        Navigator.pushNamed(context, '/selection');
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
        LargeCustomButton(
          onPressed: () => _onChoiceButtonPress(),
          child: Text('What should I eat?'),
        ),
        SizedBox(height: 20.0),
        LargeCustomButton(
          onPressed: () => _showAddFavoritePanel(),
          child: Text('Add favorite food'),
        ),
        Expanded(child: FavoritesList()),
      ],
    ));
  }
}
