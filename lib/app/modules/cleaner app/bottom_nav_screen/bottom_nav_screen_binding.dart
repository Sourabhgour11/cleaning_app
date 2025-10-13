import 'package:get/get.dart';

import 'bottom_nav_screen_controller.dart';

class CleanerBottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CleanerBottomNavController>(() => CleanerBottomNavController());
  }
}
