import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:cleaning_app/app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';

import 'profile_option_tile.dart';
import 'profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppStyle.appBarStyle("My Account",isBackButton: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // --- Profile Header ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColours.appColor.withOpacity(0.1),
                    child: Icon(Icons.person, color: AppColours.appColor, size: 40),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                    controller.userName.value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  )),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                    controller.phoneNumber.value,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: AppFonts.fontFamily,
                    ),
                  )),
                ],
              ),
            ),

            // --- Menu Options ---
            const SizedBox(height: 8),
            ProfileOptionTile(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () => Get.snackbar('Profile', 'Open profile settings'),
            ),
            ProfileOptionTile(
              icon: Icons.favorite_border,
              title: 'Favorites',
              onTap: () {
                Get.toNamed(AppRoutes.favourite);
              },
            ),
            ProfileOptionTile(
              icon: Icons.credit_card,
              title: 'Payment Methods',
              onTap: () {},
            ),
            // ProfileOptionTile(
            //   icon: Icons.card_giftcard_outlined,
            //   title: 'Referral Credits',
            //   onTap: () {},
            // ),
            // ProfileOptionTile(
            //   icon: Icons.card_giftcard,
            //   title: 'Gift Card',
            //   onTap: () {},
            // ),
            // ProfileOptionTile(
            //   icon: Icons.help_outline,
            //   title: 'Get Help',
            //   onTap: () {},
            // ),
            ProfileOptionTile(
              icon: Icons.delete_outline,
              title: 'Delete Account',
              onTap: () {
                Get.toNamed(AppRoutes.deleteAccount);
              },
            ), ProfileOptionTile(
              icon: Icons.description_outlined,
              title: 'Terms & Condition',
              onTap: () {},
            ), ProfileOptionTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () {},
            ), ProfileOptionTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {},
            ),

            // --- Logout ---
            const SizedBox(height: 12),
            GestureDetector(
              onTap: (){
                controller.showLogoutDialog();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Log Out",
                  style: TextStyle(decoration: TextDecoration.underline,decorationColor: Colors.redAccent,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 90),
            // Container(height: 200,width: 12,color: Colors.green,),
          ],
        ),
      ),
    );
  }
}
