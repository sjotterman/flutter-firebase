import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/shared/constants.dart';

class SelectionData extends ChangeNotifier {
  List<Favorite> _options = [];
  Favorite _finalSelection;
  selectionGroupType _groupType;
  String _sessionCode;

  String get sessionCode => _sessionCode;

  set sessionCode(code) {
    //should there be validation here?
    _sessionCode = code;
  }

  Favorite get finalSelection => _finalSelection;

  UnmodifiableListView<Favorite> get options => UnmodifiableListView(_options);

  void setOptions(List<Favorite> favorites) {
    _options.clear();
    favorites.forEach((f) {
      _options.add(f);
    });
    notifyListeners();
  }

  void setOptionsForUsers(List<UserData> users) {
    List<Favorite> newOptions = [];
    users.forEach((user) {
      newOptions.addAll(user.favorites);
    });
    setOptions(newOptions);
  }

  selectionGroupType get groupType {
    return _groupType;
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
    _finalSelection = null;
    _groupType = null;
    _options = [];
    notifyListeners();
  }

  void selectGroupType(selectionGroupType groupType) {
    _groupType = groupType;
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
    //TODO: remove print
    print('Choosing from options:');
    _options.forEach((option) {
      print("${option.name} - ${option.foodType}");
    });
    var randomIndex = rng.nextInt(_options.length);
    _finalSelection = _options[randomIndex];
    notifyListeners();
  }
}
