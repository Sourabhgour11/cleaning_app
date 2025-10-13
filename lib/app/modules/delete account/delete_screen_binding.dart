import 'package:get/get.dart';

import 'delete_screen_controller.dart';

class DeleteScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeleteScreenController());
  }
}
