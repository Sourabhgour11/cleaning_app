import 'package:cleaning_app/app/modules/user%20app/change_password_screen/change_password_screen_controller.dart';
import 'package:get/get.dart';

class ChangePasswordScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}