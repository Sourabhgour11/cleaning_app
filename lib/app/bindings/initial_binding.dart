import 'package:cleaning_app/app/modules/onboarding_screen/onboarding_screen_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Register controllers globally if needed
    Get.put(OnboardingScreenController());
  }
}
