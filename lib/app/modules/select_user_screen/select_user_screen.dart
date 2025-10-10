import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';
import 'package:cleaning_app/app/utils/app_images.dart';
import 'package:cleaning_app/app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectUserScreen extends StatelessWidget {
  const SelectUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Widget userOption(String title, VoidCallback onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: screenWidth * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: AppColours.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: AppFonts.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColours.appColor, // assuming you have primary color
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.selectUserType,
              style: TextStyle(
                fontFamily: AppFonts.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: AppColours.white,
              ),
            ),
            const SizedBox(height: 40),
            // Login as User
            userOption(AppStrings.loginAsUser, () {
              Get.toNamed(AppRoutes.login, arguments: 'User');
              // Navigate to User Login Screen
            }),
            // Login as Cleaner
            userOption(AppStrings.loginAsCleaner, () {
              Get.toNamed(AppRoutes.login, arguments: 'Cleaner');
              // Navigate to Cleaner Login Screen
            }),
          ],
        ),
      ),
    );
  }
}
