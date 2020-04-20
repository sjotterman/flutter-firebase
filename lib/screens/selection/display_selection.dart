import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/shared/small_custom_button.dart';

class DisplaySelection extends StatelessWidget {
  const DisplaySelection({
    Key key,
    @required this.selection,
    @required this.resetSelection,
  }) : super(key: key);

  final Favorite selection;
  final Null Function() resetSelection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selection"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your ${selection.foodType} meal should be: ',
              style: TextStyle(fontSize: 40.0),
            ),
            SizedBox(height: 60.0),
            Text(
              selection.name,
              style: TextStyle(fontSize: 40.0),
            ),
            SizedBox(height: 60.0),
            SmallCustomButton(
              onPressed: resetSelection,
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
