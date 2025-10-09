import 'package:get/get.dart';

import 'sign_up_screen_controller.dart';

class SignUpScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpScreenController>(() => SignUpScreenController());
  }
}
