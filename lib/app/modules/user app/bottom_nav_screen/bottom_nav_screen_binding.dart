import 'package:get/get.dart';

import 'bottom_nav_screen_controller.dart';


class UserBottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserBottomNavController>(() => UserBottomNavController());
  }
}
