import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class AddFavoriteForm extends StatefulWidget {
  @override
  _AddFavoriteFormState createState() => _AddFavoriteFormState();
}

class _AddFavoriteFormState extends State<AddFavoriteForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<String> foodTypes = ['Homemade', 'Takeout', 'Sit-down'];

  String _currentName;
  String _currentFoodType;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Add a favorite food',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Type'),
                  value: _currentFoodType,
                  items: foodTypes.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  validator: (val) =>
                      val == null ? 'Please select a type' : null,
                  onChanged: (val) {
                    setState(() => _currentFoodType = val);
                  },
                ),
                SizedBox(height: 20.0),
                //slider
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateFavorite(
                        _currentName ?? userData.name,
                        _currentFoodType ?? 'Homemade',
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        });
  }
}
