import 'package:flutter/material.dart';
import 'package:flutter_firebase/provider_models/selection_data.dart';
import 'package:flutter_firebase/screens/selection/choose_food_type.dart';
import 'package:flutter_firebase/screens/selection/display_selection.dart';
import 'package:provider/provider.dart';

class Selection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectionData = Provider.of<SelectionData>(context);
    /*
    * TODO: logic to change which page displays depending on the selected
    * groupType. Right now we can get to DisplaySelection from this file,
    * or using navigator. This is inconsistent.
    */
    if (selectionData.finalSelection != null) {
      return DisplaySelection();
    }
    return ChooseFoodType();
  }
}
