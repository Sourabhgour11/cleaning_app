import 'package:get/get.dart';
import 'announcement_screen_controller.dart';

class AnnouncementScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnnouncementScreenController());
  }
}
