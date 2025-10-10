import 'package:get/get.dart';
import 'book_service_screen_controller.dart';

class BookServiceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookServiceScreenController>(() => BookServiceScreenController());
  }
}
