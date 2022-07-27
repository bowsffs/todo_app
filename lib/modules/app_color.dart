import 'package:flutter/material.dart' show Color;
import 'package:todo_app/db/boxes.dart';
import 'package:todo_app/models/color.dart';

class AppColor {
  static const List<int> allPrimaryColors = [
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
    0xFF070606, //meshki
  ];

  static int currentColorHex =
      Boxes.getColor().values.toList().cast<ColorSchemeRoozane>()[0].hex;

  static Color currentAppColor = Color(currentColorHex);

  static void changeAppColor(int colorIndex) {
    currentColorHex = allPrimaryColors[colorIndex];
    currentAppColor = Color(currentColorHex);

    final dynamic key =
        Boxes.getColor().values.toList().cast<ColorSchemeRoozane>()[0].key;

    Boxes.getColor().putAt(key, ColorSchemeRoozane()..hex = currentColorHex);
  }
}
