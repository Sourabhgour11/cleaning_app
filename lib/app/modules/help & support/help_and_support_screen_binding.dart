import 'package:get/get.dart';

import 'help_and_support_screen_controller.dart';

class HelpAndSupportScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpAndSupportScreenController());
  }
}