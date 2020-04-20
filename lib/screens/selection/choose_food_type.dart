import 'package:flutter/material.dart';
import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/shared/large_custom_button.dart';
import 'package:flutter_firebase/shared/small_custom_button.dart';
import 'package:provider/provider.dart';

class ChooseFoodType extends StatelessWidget {
  const ChooseFoodType({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            LargeCustomButton(
              onPressed: selectionData.numTakeout <= 1
                  ? null
                  : () {
                      _selectTakeout();
                    },
              child: Text('Takeout'),
            ),
            SizedBox(height: 20.0),
            LargeCustomButton(
              onPressed: selectionData.numSitdown <= 1
                  ? null
                  : () {
                      _selectSitDown();
                    },
              child: Text('Sit-down'),
            ),
            SizedBox(height: 20.0),
            LargeCustomButton(
              onPressed: selectionData.numHomemade <= 1
                  ? null
                  : () {
                      _selectHomemade();
                    },
              child: Text('Homemade'),
            ),
            SizedBox(height: 20.0),
            LargeCustomButton(
              onPressed: () {
                _selectRandom();
              },
              color: Colors.green,
              child: Text('Surprise me!'),
            ),
            SizedBox(height: 60.0),
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
