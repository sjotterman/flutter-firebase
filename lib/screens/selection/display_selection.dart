import 'package:flutter/material.dart';
import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/shared/small_custom_button.dart';
import 'package:provider/provider.dart';

class DisplaySelection extends StatelessWidget {
  const DisplaySelection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectionData = Provider.of<SelectionData>(context);
    final selection = selectionData.finalSelection;
    final resetSelection = () {
      // Navigate back to the first screen by popping the current route
      // off the stack.
      selectionData.resetSelection();
      Navigator.pop(context);
    };
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
              textAlign: TextAlign.center,
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