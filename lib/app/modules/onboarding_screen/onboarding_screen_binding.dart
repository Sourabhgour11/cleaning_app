import 'package:cleaning_app/app/modules/onboarding_screen/onboarding_screen_controller.dart';
import 'package:get/get.dart';

class OnboardingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingScreenController>(() => OnboardingScreenController());
  }
}