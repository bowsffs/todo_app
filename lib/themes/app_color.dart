import 'package:flutter/material.dart' show Colors, Color;

class AppColor {
  static final List<Color> allPrimaryColors = [
    Colors.red,
    Colors.deepOrange,
    Colors.lightGreenAccent[700]!,
    Colors.green,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blue,
    Colors.teal,
    Colors.purple[400]!,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.brown,
    Colors.grey[700]!,
    Colors.black,
  ];

  static Color currentAppColor = allPrimaryColors[1];

  static void nextColor(){
    currentAppColor = allPrimaryColors[allPrimaryColors.];
  }



}
