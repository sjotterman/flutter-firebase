import 'package:flutter_firebase/models/user.dart';

import 'favorite.dart';

class Session {
  final String id;
  final String sessionCode;
  final UserData creator;
  final Favorite selection;
  List<UserData> members;

  Session(
      {this.id, this.sessionCode, this.creator, this.members, this.selection});
}
