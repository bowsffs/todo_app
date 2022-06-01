import 'package:flutter/material.dart' show Color;
import 'package:todo_app/db/boxes.dart';
import 'package:todo_app/models/color.dart';

class AppColor {
  AppColor._();

  static const List<int> _allPrimaryColors = [
    0xFFF44336, //ghermez
    0xFFFF9800, //narangi
    0xFF4CAF50, //sabz kam rang mat
    0xFF00BCD4, //abi kam rang
    0xFF03A9F4, //abi
    0xFF009688, //cyan
    0xFF9C27B0, //banafsh
    0xFF673AB7, //banafsh mat
    0xFF3F51B5, //toosi
    0xFF9E9E9E, // khakestari
    0xFF795548, // ghahveii
    0xFF000000, //meshki
  ];

  static int currentColorHex =
      Boxes.getColor().values.toList().cast<ColorSchemeRoozane>()[0].hex;
  static Color currentAppColor = Color(currentColorHex);
  static int index =
      Boxes.getColor().values.toList().cast<ColorSchemeRoozane>()[0].index;

  static int _incrementIndex() {
    index = index + 1;
    return index;
  }

  static int _decrementIndex() {
    index = index - 1;
    return index;
  }

  static void nextColor() {
    if (index < _allPrimaryColors.length - 1) {
      currentColorHex = _allPrimaryColors[_incrementIndex()];
      currentAppColor = Color(currentColorHex);

      final dynamic keyy =
          Boxes.getColor().values.toList().cast<ColorSchemeRoozane>()[0].key;

      Boxes.getColor().putAt(
          keyy,
          ColorSchemeRoozane()
            ..hex = currentColorHex
            ..index = index);
    } else {
      index = 0;
      currentColorHex = _allPrimaryColors[0];
      currentAppColor = Color(currentColorHex);

      final dynamic keyy =
          Boxes.getColor().values.toList().cast<ColorSchemeRoozane>()[0].key;

      Boxes.getColor().putAt(
          keyy,
          ColorSchemeRoozane()
            ..hex = currentColorHex
            ..index = index);
    }
  }

  static void previousColor() {
    if (index > 0) {
      currentColorHex = _allPrimaryColors[_decrementIndex()];
      currentAppColor = Color(currentColorHex);

      final dynamic keyy =
          Boxes.getColor().values.toList().cast<ColorSchemeRoozane>()[0].key;

      Boxes.getColor().putAt(
          keyy,
          ColorSchemeRoozane()
            ..hex = currentColorHex
            ..index = index);
    } else {
      currentColorHex = _allPrimaryColors[_allPrimaryColors.length - 1];
      currentAppColor = Color(currentColorHex);
      index = _allPrimaryColors.length - 1;

      final dynamic keyy =
          Boxes.getColor().values.toList().cast<ColorSchemeRoozane>()[0].key;

      Boxes.getColor().putAt(
          keyy,
          ColorSchemeRoozane()
            ..hex = currentColorHex
            ..index = index);
    }
  }
}
