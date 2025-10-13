import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_cleaner_bottom_bar.dart';
import 'bottom_nav_screen_controller.dart';

class CleanerBottomNavScreen extends GetView<CleanerBottomNavController> {
  const CleanerBottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CleanerBottomNavController());

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
                () => CleanerModernBottomBar(
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
