import 'package:get/get.dart';

import 'book_service_step4_screen_controller.dart';

class BookServiceStep4ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookServiceStep4ScreenController>(() => BookServiceStep4ScreenController());
  }
}
