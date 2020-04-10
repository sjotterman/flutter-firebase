import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/add_favorite_form.dart';
import 'package:flutter_firebase/screens/home/favorites_list.dart';

class FavoritesOverview extends StatelessWidget {
  const FavoritesOverview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {},
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('Let\'s eat!'),
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
          child: Text('Add Favorite'),
        ),
        Expanded(child: FavoritesList()),
      ],
    ));
  }
}
