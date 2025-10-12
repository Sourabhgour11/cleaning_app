import 'package:get/get.dart';

import 'incentive_screen_controller.dart';

class IncentiveScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IncentiveScreenController());
  }
}
