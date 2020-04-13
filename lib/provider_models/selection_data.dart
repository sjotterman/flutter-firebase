import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/favorite.dart';

class SelectionData extends ChangeNotifier {
  List<Favorite> _options = [];
  Favorite finalSelection;

  UnmodifiableListView<Favorite> get options => UnmodifiableListView(_options);

  void setOptions(List<Favorite> favorites) {
    _options.clear();
    favorites.forEach((f) {
      _options.add(f);
    });
    _options.forEach((f) => print(f.name));
    notifyListeners();
  }

  int get numTakeout {
    return _options
        .where((item) {
          return item.foodType == 'Takeout';
        })
        .toList()
        .length;
  }

  int get numHomemade {
    return _options
        .where((item) {
          return item.foodType == 'Homemade';
        })
        .toList()
        .length;
  }

  int get numSitdown {
    return _options
        .where((item) {
          return item.foodType == 'Sit-down';
        })
        .toList()
        .length;
  }

  void resetSelection() {
    finalSelection = null;
    notifyListeners();
  }

  void chooseHomemade() {
    _options = _options.where((item) {
      return item.foodType == 'Homemade';
    }).toList();
    chooseRandomly();
  }

  void chooseSitdown() {
    _options = _options.where((item) {
      return item.foodType == 'Sit-down';
    }).toList();
    chooseRandomly();
  }

  void chooseTakeout() {
    _options = _options.where((item) {
      return item.foodType == 'Takeout';
    }).toList();
    chooseRandomly();
  }

  void chooseRandomly() {
    var rng = new Random();
    var randomIndex = rng.nextInt(_options.length);
    finalSelection = _options[randomIndex];
    notifyListeners();
  }
}