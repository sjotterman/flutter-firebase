import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/home/favorites_list.dart';
import 'package:flutter_firebase/screens/home/settings_form.dart';
import 'package:flutter_firebase/screens/home/add_favorite_form.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

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

    final user = Provider.of<User>(context);

    return StreamProvider<FavoriteData>.value(
      value: DatabaseService(uid: user.uid).favoriteData,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Stockkeeper'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('log out'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/coffee_bg.png'), fit: BoxFit.cover),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                MaterialButton(
                  height: 60.0,
                  minWidth: 190.0,
                  onPressed: () {},
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Let\'s eat!'),
                ),
                SizedBox(height: 20.0),
                MaterialButton(
                  height: 60.0,
                  minWidth: 190.0,
                  onPressed: () => _showAddFavoritePanel(),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Add Favorite'),
                ),
                FavoritesList(),
              ],
            )),
      ),
    );
  }
}
