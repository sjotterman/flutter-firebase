class Favorite {
  final String name;
  final String userId;

  Favorite({this.userId, this.name});
}

class FavoriteData {
  List<Favorite> favorites;

  FavoriteData({this.favorites});
}
