import 'package:flutter_firebase/models/user.dart';

class Session {
  final String id;
  final String sessionCode;
  final UserData creator;
  List<UserData> members;

  Session({this.id, this.sessionCode, this.creator, this.members});
}
