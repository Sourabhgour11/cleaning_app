import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:cleaning_app/app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';

import 'profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppStyle.heightPercent(context, 60)),
        child: _buildProfileHeader(context, controller),
      ),
      body: SafeArea(child: Obx(() => _buildContent(context, controller))),
    );
  }

  Widget _buildContent(BuildContext context, ProfileController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Statistics Cards
          _buildStatisticsCards(controller),
          const SizedBox(height: 20),
          // Menu Items
          _buildMenuItems(controller),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(
      BuildContext context,
      ProfileController controller,
      ) {
    final height = AppStyle.heightPercent(context, 30); // 20% of screen
    final width = AppStyle.widthPercent(context, 100);

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: AppColours.gradientColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: height * 0.15, // dynamic top spacing
          left: width * 0.05,
          right: width * 0.05,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile Image
            CircleAvatar(
              radius: height * 0.18, // responsive radius
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: height * 0.29,
                backgroundColor: AppColours.appColor.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: AppColours.appColor,
                  size: height * 0.2,
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            // Name and Verification
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                      () => Flexible(
                    child: Text(
                      controller.userName.value,
                      style: TextStyle(
                        fontSize: height * 0.12, // responsive font
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: AppFonts.fontFamily,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Container(
                  padding: EdgeInsets.all(height * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: height * 0.08,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            // Phone Number
            Obx(
                  () => Text(
                controller.phoneNumber.value,
                style: TextStyle(
                  fontSize: height * 0.07,
                  color: Colors.white70,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildStatisticsCards(ProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(onTap: (){
              Get.toNamed(AppRoutes.userBookingScreen, arguments: {'showBack': true});
            },
              child: _buildStatCard(
                'Total Bookings',
                '${controller.profileData['totalBookings']}',
                Icons.calendar_today,
                Colors.blue,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(onTap: (){
              Get.toNamed(AppRoutes.favourite);
            },
              child: _buildStatCard(
                'Favorites',
                '${controller.profileData['favorites']}',
                Icons.favorite,
                Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontFamily: AppFonts.fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(ProfileController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: controller.menuItems
            .map((item) => _buildMenuItem(item, controller))
            .toList(),
      ),
    );
  }

  Widget _buildMenuItem(
    Map<String, dynamic> item,
    ProfileController controller,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (item['color'] as Color).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          item['icon'] as IconData,
          color: item['color'] as Color,
          size: 20,
        ),
      ),
      title: Text(
        item['title'] as String,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColours.black,
          fontFamily: AppFonts.fontFamily,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () => controller.handleMenuAction(item['action'] as String),
    );
  }
}
