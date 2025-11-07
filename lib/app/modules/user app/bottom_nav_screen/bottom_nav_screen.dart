import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bottom_nav_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_user_bottom_bar.dart';

class UserBottomNavScreen extends StatelessWidget {

  final UserBottomNavController controller = Get.put(UserBottomNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Stack(
          children: [
            // Keeps all screens alive and only switches visibility
            IndexedStack(
              index: controller.selectedIndex.value,
              children: controller.screens,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AppUserBottomBar(
                currentIndex: controller.selectedIndex.value,
                onTabChanged: controller.onTabChanged,
              ),
            ),
          ],
        );
      }),
    );
  }
}
