import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/services/database.dart';
// import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/shared/large_custom_button.dart';
import 'package:flutter_firebase/shared/small_custom_button.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/validation.dart';
import 'package:provider/provider.dart';

class JoinGroup extends StatefulWidget {
  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  final _formKey = GlobalKey<FormState>();
  String _currentCode;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final selectionData = Provider.of<SelectionData>(context);
    Future<void> _joinSession() async {
      if (_formKey.currentState.validate()) {
        print("valid session!");
        var db = DatabaseService(uid: user.uid);
        var joined = await db.joinSession(_currentCode);
        if (joined) {
          selectionData.sessionCode = _currentCode;
          Navigator.pushNamed(context, '/displaySelection');
        } else {
          print("error joining");
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Join a group"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
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
                  validator: SelectionCodeValidator.validate,
                  onChanged: (val) {
                    setState(() => _currentCode = val.toUpperCase());
                  }),
              SizedBox(height: 20.0),
              LargeCustomButton(
                child: Text('Join'),
                onPressed: _joinSession,
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
      ),
    );
  }
}
