import 'package:get/get.dart';
import 'bottom_nav_screen_controller.dart';

class PartnerBottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerBottomNavController>(() => PartnerBottomNavController());
  }
}
