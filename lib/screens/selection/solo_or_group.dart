import 'package:flutter/material.dart';
import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/shared/large_custom_button.dart';
import 'package:flutter_firebase/shared/small_custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase/shared/constants.dart';

class SoloOrGroupSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectionData = Provider.of<SelectionData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("How many?"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Solo, or in a group?',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 60.0),
            LargeCustomButton(
              onPressed: () {
                selectionData.selectGroupType(selectionGroupType.solo);
                Navigator.pushNamed(context, '/selection');
              },
              child: Text('Solo'),
            ),
            SizedBox(height: 20.0),
            LargeCustomButton(
              onPressed: () {
                selectionData.selectGroupType(selectionGroupType.group);
                Navigator.pushNamed(context, '/joinOrCreateGroup');
              },
              child: Text('Group'),
            ),
            SizedBox(height: 20.0),
            SmallCustomButton(
              onPressed: () {
                // Navigate back to the first screen by popping the current route
                // off the stack.
                Navigator.pop(context);
              },
              color: Colors.blue,
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
