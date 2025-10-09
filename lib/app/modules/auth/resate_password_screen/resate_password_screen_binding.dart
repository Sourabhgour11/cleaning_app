import 'package:get/get.dart';
import 'resate_password_screen_controller.dart';

class ResatePasswordScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResatePasswordScreenController());
  }
}
