import 'package:flutter/material.dart';
// import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/shared/large_custom_button.dart';
import 'package:flutter_firebase/shared/small_custom_button.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_firebase/shared/constants.dart';

class JoinGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final selectionData = Provider.of<SelectionData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Join a group"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter Code',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 60.0),
            ),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Code'),
                validator: (val) => val.isEmpty ? 'Please enter a code' : null,
                onChanged: (val) {
                  print(val);
                }),
            SizedBox(height: 20.0),
            LargeCustomButton(
              child: Text('Join'),
              onPressed: () {},
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
