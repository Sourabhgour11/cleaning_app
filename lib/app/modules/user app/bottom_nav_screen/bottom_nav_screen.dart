import 'package:cleaning_app/app/utils/app_bottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_nav_screen_controller.dart';

class UserBottomNavScreen extends GetView<UserBottomNavController> {
  const UserBottomNavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserBottomNavController controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Stack(
          children: [
            controller.screens[controller.selectedIndex.value],
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Obx(
                    () => ModernBottomBar(
                  currentIndex: controller.selectedIndex.value,
                  onTabChanged: controller.onTabChanged,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
