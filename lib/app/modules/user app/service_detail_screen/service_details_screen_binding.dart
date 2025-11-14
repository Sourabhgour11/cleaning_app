import 'package:get/get.dart';

import 'service_details_screen_controller.dart';

class ServiceDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceDetailsScreenController>(() => ServiceDetailsScreenController());
  }
}
