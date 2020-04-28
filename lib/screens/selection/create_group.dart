import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/session.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/services/database.dart';
// import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/shared/large_custom_button.dart';
import 'package:flutter_firebase/shared/small_custom_button.dart';
import 'package:provider/provider.dart';

class CreateGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectionData = Provider.of<SelectionData>(context);
    final user = Provider.of<User>(context);
    // final user = Provider.of<User>(context);
    final mySession = Provider.of<Session>(context);
    List<UserData> usersJoined = [];
    String sessionCode = 'xxxx';
    if (mySession != null) {
      sessionCode = mySession.sessionCode;
      usersJoined = mySession.members;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a group"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Group code:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              sessionCode,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 60.0),
            ),
            Text(
              'Give this code to your group members.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Click the button when your entire group has joined',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            LargeCustomButton(
              child: Text('All of us are here!'),
              onPressed: () async {
                // TODO: extract this logic into a function
                selectionData.setOptionsForUsers(mySession.members);
                selectionData.chooseRandomly();
                var selection = selectionData.finalSelection;
                await DatabaseService(uid: user.uid)
                    .setGroupSelection(selection);
                // Need to reset the session, or we'll end up using the same one
                Navigator.pushNamed(context, '/displaySelection');
              },
            ),
            // TODO: make this list pretty
            ListView.builder(
              shrinkWrap: true,
              itemCount: usersJoined.length,
              itemBuilder: (context, index) {
                return Text(
                  usersJoined[index].name,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                );
              },
            ),
            SizedBox(height: 40.0),
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
