import 'package:get/get.dart';
import 'book_service_step1_screen_controller.dart';

class BookServiceStep1ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookServiceStep1ScreenController>(() => BookServiceStep1ScreenController());
  }
}
