class Favorite {
  final String name;
  final String foodType;
  final String userId;

  Favorite({this.userId, this.foodType, this.name});
}

class FavoriteData {
  List<Favorite> favorites;

  FavoriteData({this.favorites});
}
