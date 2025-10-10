import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  //-------------------------------- AppBar Style --------------------------------
  static AppBar appBarStyle(String title, {bool isBackButton = true}) => AppBar(
    automaticallyImplyLeading: isBackButton,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColours.appColor,
    elevation: 0,
    centerTitle: true,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: AppColours.gradientColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
    ),
    leading: isBackButton
        ? Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: IconButton(
              onPressed: () => Get.back(),
              color: AppColours.white,
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            ),
          )
        : null,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColours.white,
        fontFamily: AppFonts.fontFamily,
        letterSpacing: 0.5,
        shadows: [
          Shadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 2),
        ],
      ),
    ),
    actions: [
      // Container(
      //   margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
      //   decoration: BoxDecoration(
      //     color: Colors.white.withOpacity(0.2),
      //     borderRadius: BorderRadius.circular(12),
      //     border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      //   ),
      //   child: IconButton(
      //     onPressed: () {
      //       // Add notification or menu action here
      //     },
      //     color: AppColours.white,
      //     icon: const Icon(Icons.notifications_outlined, size: 22),
      //   ),
      // ),
    ],
  );

//-------------------------------- AppBar Style --------------------------------
  static AppBar appBarStyle(String title, {bool isBackButton = true}) => AppBar(
    automaticallyImplyLeading: isBackButton,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColours.white,
    elevation: 0,
    centerTitle: true,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColours.appColor, AppColours.appColor2],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
    ),
    leading: isBackButton
        ? Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: () => Get.back(),
        color: AppColours.white,
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
      ),
    )
        : null,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColours.white,
        fontFamily: AppFonts.fontFamily,
        letterSpacing: 0.5,
        shadows: [
          Shadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 2),
        ],
      ),
    ),
    actions: [
      // Container(
      //   margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
      //   decoration: BoxDecoration(
      //     color: Colors.white.withOpacity(0.2),
      //     borderRadius: BorderRadius.circular(12),
      //     border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      //   ),
      //   child: IconButton(
      //     onPressed: () {
      //       // Add notification or menu action here
      //     },
      //     color: AppColours.white,
      //     icon: const Icon(Icons.notifications_outlined, size: 22),
      //   ),
      // ),
    ],
  );
}


