import 'package:get/get.dart';
import 'book_service_step2_screen_controller.dart';

class BookServiceStep2ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookServiceStep2ScreenController>(() => BookServiceStep2ScreenController());
  }
}
