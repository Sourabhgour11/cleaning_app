import 'package:get/get.dart';

import 'bottom_nav_screen_controller.dart';


class UserBottoNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserBottomNavController>(() => UserBottomNavController());
  }
}
