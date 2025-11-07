import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:cleaning_app/app/utils/app_images.dart';
import 'package:cleaning_app/app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreenController extends GetxController {
  var pageIndex = 0.obs;
  final int totalPages = 3;
  late final PageController pageController;

  final List<Map<String, String>> onboardingData = const [
    {
      'title': AppStrings.welcomeToCleaningApp,
      'subtitle': AppStrings.bookCleaningServicesEasily,
      'image': AppImages.vaccumOnboardingImage,
    },
    {
      'title': AppStrings.chooseYourService,
      'subtitle': AppStrings.selectFromVariousCleaningServices,
      'image': AppImages.dustbinOnboardingImage,
    },
    {
      'title': AppStrings.getItDone,
      'subtitle': AppStrings.sitBackAndRelaxWeHandleTheRest,
      'image': AppImages.garbageOnboardingImage,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void nextPage()async{
    if (pageIndex.value < totalPages - 1) {
      pageIndex.value++;
      pageController.animateToPage(
        pageIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else  {
      completeOnboarding();
      SharedPreferences  prefs = await SharedPreferences.getInstance();
      prefs.setInt("appStatus" , 1);
      print("${prefs.getInt("appStatus")}");
    }
  }

  void skip() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    try {
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setBool('seenOnboarding', true);
      debugPrint("Onboarding status saved successfully");
      Get.offAllNamed(AppRoutes.login);
      SharedPreferences  prefs = await SharedPreferences.getInstance();
      prefs.setInt("appStatus" , 1);
      print("${prefs.getInt("appStatus")}");
    } catch (e) {
      debugPrint("Error saving onboarding status: $e");
      // Fallback: Navigate to select user screen even if shared_preferences fails
      // Get.offAllNamed(AppRoutes.selectUserScreen);

      // Show a warning to the user
      Get.snackbar(
        'Warning',
        'Unable to save preferences, but you can continue using the app.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose(); // prevent memory leaks
    super.onClose();
  }
}
