import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
    width: 2.0,
  )),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: Colors.blue,
    width: 2.0,
  )),
);

enum selectionGroupType {
  solo,
  group,
}
