import 'package:flutter/material.dart';

class AppColours {
  // static const appColor = Color.fromARGB(255, 21, 88, 204);
  static const appColor = Color(0xff00a6a6);
  static const appColor2 = Color.fromARGB(255, 15, 50, 110);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color red = Colors.red;
  static const Color blue = Colors.blue;
  static const Color green = Colors.green;
  static const Color yellow = Colors.yellow;
  static const Color orange = Colors.orange;

  static const Gradient gradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColours.appColor, AppColours.appColor2],
  );
}
