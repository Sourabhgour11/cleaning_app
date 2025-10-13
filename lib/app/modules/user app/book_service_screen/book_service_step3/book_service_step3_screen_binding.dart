import 'package:get/get.dart';

import 'book_service_step3_screen_controller.dart';

class BookServiceStep3ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookServiceStep3ScreenController>(() => BookServiceStep3ScreenController());
  }
}
