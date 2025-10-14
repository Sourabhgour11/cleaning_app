import 'package:cleaning_app/app/modules/user%20app/booking_details_screen/booking_details_screen_controller.dart';
import 'package:get/get.dart';


class BookingDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailsController>(() => BookingDetailsController());
  }
}
