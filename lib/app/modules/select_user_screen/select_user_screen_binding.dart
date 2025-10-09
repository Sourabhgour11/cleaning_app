import 'package:cleaning_app/app/modules/home_screen/home_screen_controller.dart';
import 'package:cleaning_app/app/modules/select_user_screen/select_user_screen_controller.dart';
import 'package:get/get.dart';

class SelectUserScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectUserScreenController>(() => SelectUserScreenController());
  }
}
