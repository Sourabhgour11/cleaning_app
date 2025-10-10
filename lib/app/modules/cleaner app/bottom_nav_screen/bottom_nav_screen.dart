import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_bottom_bar.dart';
import 'bottom_nav_screen_controller.dart';

class BottomNavScreen extends GetView<BottomNavController> {
  BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavController());

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
