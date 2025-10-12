import 'package:get/get.dart';

import 'booking_screen_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookingController());
  }
}
