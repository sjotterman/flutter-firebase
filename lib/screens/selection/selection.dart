import 'package:flutter/material.dart';
import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/screens/selection/large_selection_button.dart';
import 'package:provider/provider.dart';

class Selection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: refactor this into multiple widgets
    final selectionData = Provider.of<SelectionData>(context);

    void _selectTakeout() {
      selectionData.chooseTakeout();
    }

    void _selectSitDown() {
      selectionData.chooseSitdown();
    }

    void _selectHomemade() {
      selectionData.chooseHomemade();
    }

    void _selectRandom() {
      selectionData.chooseRandomly();
    }

    if (selectionData.finalSelection != null) {
      final name = selectionData.finalSelection.name;
      final foodType = selectionData.finalSelection.foodType;
      return Scaffold(
        appBar: AppBar(
          title: Text("Selection"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your $foodType meal should be: ',
                style: TextStyle(fontSize: 40.0),
              ),
              SizedBox(height: 60.0),
              Text(
                name,
                style: TextStyle(fontSize: 40.0),
              ),
              SizedBox(height: 60.0),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                height: 30.0,
                minWidth: 90.0,
                onPressed: () {
                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                  selectionData.resetSelection();
                  Navigator.pop(context);
                },
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Go back!'),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Select a meal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'What kind of meal do you want?',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 60.0),
            LargeSelectionButton(
              onPressed: selectionData.numTakeout <= 1
                  ? null
                  : () {
                      _selectTakeout();
                    },
              child: Text('Takeout'),
            ),
            SizedBox(height: 20.0),
            LargeSelectionButton(
              onPressed: selectionData.numSitdown <= 1
                  ? null
                  : () {
                      _selectSitDown();
                    },
              child: Text('Sit-down'),
            ),
            SizedBox(height: 20.0),
            LargeSelectionButton(
              onPressed: selectionData.numHomemade <= 1
                  ? null
                  : () {
                      _selectHomemade();
                    },
              child: Text('Homemade'),
            ),
            SizedBox(height: 20.0),
            LargeSelectionButton(
              onPressed: () {
                _selectRandom();
              },
              color: Colors.green,
              child: Text('Surprise me!'),
            ),
            SizedBox(height: 60.0),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              height: 30.0,
              minWidth: 90.0,
              onPressed: () {
                // Navigate back to the first screen by popping the current route
                // off the stack.
                Navigator.pop(context);
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
