import 'package:flutter_firebase/models/favorite.dart';
import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<Favorite> exampleFavorites = [
    Favorite(
      name: 'pizza',
      foodType: 'Takeout',
      userId: '123',
    ),
    Favorite(
      name: 'pasta',
      foodType: 'Takeout',
      userId: '123',
    ),
    Favorite(
      name: 'noodles',
      foodType: 'Homemade',
      userId: '123',
    ),
    Favorite(
      name: 'sandwich',
      foodType: 'Homemade',
      userId: '123',
    ),
    Favorite(
      name: 'Italian',
      foodType: 'Sit-down',
      userId: '123',
    ),
    Favorite(
      name: 'Steak',
      foodType: 'Sit-down',
      userId: '123',
    ),
  ];
  test('Set options', () {
    SelectionData selectionData = SelectionData();
    expect(selectionData.options, []);
    selectionData.setOptions(exampleFavorites);
    expect(selectionData.finalSelection, null);
    var firstFavorite = selectionData.options[0];
    expect(firstFavorite.name, 'pizza');
    expect(firstFavorite.foodType, 'Takeout');
    expect(firstFavorite.userId, '123');
    expect(selectionData.options.length > 2, true);
    expect(selectionData.options.length, exampleFavorites.length);
    final expectedNumTakeout =
        exampleFavorites.where((item) => item.foodType == 'Takeout').length;
    expect(selectionData.numTakeout, expectedNumTakeout);
    final expectedNumSitdown =
        exampleFavorites.where((item) => item.foodType == 'Sit-down').length;
    expect(selectionData.numSitdown, expectedNumSitdown);
    final expectedNumHomeade =
        exampleFavorites.where((item) => item.foodType == 'Homemade').length;
    expect(selectionData.numHomemade, expectedNumHomeade);
  });

  test('Select takeout', () {
    SelectionData selectionData = SelectionData();
    selectionData.setOptions(exampleFavorites);
    selectionData.chooseTakeout();
    expect(selectionData.options.length, 2);
    expect(selectionData.numTakeout, 2);
    expect(selectionData.numSitdown, 0);
    expect(selectionData.numHomemade, 0);
    expect(selectionData.finalSelection != null, true);
    expect(selectionData.finalSelection.foodType, 'Takeout');
    selectionData.resetSelection();
    expect(selectionData.finalSelection, null);
  });

  test('Select sit-down', () {
    SelectionData selectionData = SelectionData();
    selectionData.setOptions(exampleFavorites);
    selectionData.chooseSitdown();
    expect(selectionData.options.length, 2);
    expect(selectionData.numTakeout, 0);
    expect(selectionData.numSitdown, 2);
    expect(selectionData.numHomemade, 0);
    expect(selectionData.finalSelection != null, true);
    expect(selectionData.finalSelection.foodType, 'Sit-down');
    selectionData.resetSelection();
    expect(selectionData.finalSelection, null);
  });

  test('Select homemade', () {
    SelectionData selectionData = SelectionData();
    selectionData.setOptions(exampleFavorites);
    selectionData.chooseHomemade();
    expect(selectionData.options.length, 2);
    expect(selectionData.numTakeout, 0);
    expect(selectionData.numSitdown, 0);
    expect(selectionData.numHomemade, 2);
    expect(selectionData.finalSelection != null, true);
    expect(selectionData.finalSelection.foodType, 'Homemade');
    selectionData.resetSelection();
    expect(selectionData.finalSelection, null);
  });

  test('Choose randomly', () {
    SelectionData selectionData = SelectionData();
    selectionData.setOptions(exampleFavorites);
    selectionData.chooseRandomly();
    final expectedNumTakeout =
        exampleFavorites.where((item) => item.foodType == 'Takeout').length;
    expect(selectionData.numTakeout, expectedNumTakeout);
    final expectedNumSitdown =
        exampleFavorites.where((item) => item.foodType == 'Sit-down').length;
    expect(selectionData.numSitdown, expectedNumSitdown);
    final expectedNumHomeade =
        exampleFavorites.where((item) => item.foodType == 'Homemade').length;
    expect(selectionData.numHomemade, expectedNumHomeade);
    expect(selectionData.finalSelection != null, true);
    selectionData.resetSelection();
    expect(selectionData.finalSelection, null);
  });
}
