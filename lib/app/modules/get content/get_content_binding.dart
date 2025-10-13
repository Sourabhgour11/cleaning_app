import 'package:get/get.dart';

import 'get_content_screen_controller.dart';

class GetContentBinding extends Bindings {  
  @override
  void dependencies() {
    Get.lazyPut(() => GetContentScreenController());
  }
}