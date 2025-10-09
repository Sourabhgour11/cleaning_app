import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class AppStyle {
  //-------------------------------- Screen Dimensions --------------------------------
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  //-------------------------------- Responsive Dimensions --------------------------------
  static double heightPercent(BuildContext context, double percent) =>
      screenHeight(context) * percent / 100;
  static double widthPercent(BuildContext context, double percent) =>
      screenWidth(context) * percent / 100;

  static const TextStyle textfieldHeading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColours.black,
    fontFamily: AppFonts.fontFamily,
  );
}
