class Favorite {
  final String name;
  final String uid;

  Favorite({this.uid, this.name});
}

class FavoriteData {
  List<Favorite> favorites;

  FavoriteData({this.favorites});
}
