import 'package:get/get.dart';

import 'home_screen_controller.dart';

class CleanerHomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CleanerHomeScreenController());
  }
}
