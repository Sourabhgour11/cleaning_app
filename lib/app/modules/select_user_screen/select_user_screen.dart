import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';
import 'package:cleaning_app/app/utils/app_images.dart';
import 'package:cleaning_app/app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_style.dart';

class SelectUserScreen extends StatelessWidget {
  const SelectUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget userOption({
      required String title,
      required String subtitle,
      required IconData icon,
      required Color iconColor,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: AppStyle.screenWidth(context) * 90 / 100,
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.95),
                Colors.white.withOpacity(0.85),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: iconColor.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(color: iconColor.withOpacity(0.2), width: 1.5),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: AppStyle.screenWidth(context) * 80 / 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: AppStyle.screenWidth(context) * 17 / 100,
                          height: AppStyle.screenWidth(context) * 17 / 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                iconColor.withOpacity(0.1),
                                iconColor.withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: iconColor.withOpacity(0.8),
                              width: 1,
                            ),
                          ),
                          child: Icon(icon, size: 32, color: iconColor),
                        ),
                        SizedBox(
                          width: AppStyle.screenWidth(context) * 45 / 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColours.black,
                                  letterSpacing: 0.5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppFonts.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: AppStyle.screenWidth(context) * 10 / 100,
                          height: AppStyle.screenWidth(context) * 10 / 100,
                          decoration: BoxDecoration(
                            color: iconColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: iconColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        height: AppStyle.screenHeight(context),
        width: AppStyle.screenWidth(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Header Section
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.cleaning_services,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppStrings.selectUserType,
                    style: TextStyle(
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white,
                      letterSpacing: 1.0,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose your role to continue',
                    style: TextStyle(
                      fontFamily: AppFonts.fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              // User Options
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Login as User
                      userOption(
                        title: AppStrings.loginAsUser,
                        subtitle:
                            'Book cleaning services and manage your bookings',
                        icon: Icons.person,
                        iconColor: const Color(0xFF4CAF50),
                        onTap: () {
                          Get.toNamed(AppRoutes.login, arguments: 'User');
                        },
                      ),
                      // Login as Cleaner
                      userOption(
                        title: AppStrings.loginAsCleaner,
                        subtitle:
                            'Accept cleaning jobs and manage your schedule',
                        icon: Icons.cleaning_services,
                        iconColor: const Color(0xFF2196F3),
                        onTap: () {
                          Get.toNamed(AppRoutes.login, arguments: 'Cleaner');
                        },
                      ),
                      // Login as Partner
                      userOption(
                        title: AppStrings.loginAsPartner,
                        subtitle: 'Manage your cleaning business and team',
                        icon: Icons.business,
                        iconColor: const Color(0xFFFF9800),
                        onTap: () {
                          Get.toNamed(AppRoutes.login, arguments: 'Partner');
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
