import 'package:get/get.dart';

import 'home_screen_controller.dart';

class PartnerHomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PartnerHomeScreenController());
  }
}
