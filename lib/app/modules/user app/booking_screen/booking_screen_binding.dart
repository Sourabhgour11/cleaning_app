import 'package:get/get.dart';

import 'booking_screen_controller.dart';

class UserBookingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserBookingScreenController>(() => UserBookingScreenController());
  }
}
