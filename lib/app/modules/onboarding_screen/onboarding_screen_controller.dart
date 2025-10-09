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

  void nextPage() {
    if (pageIndex.value < totalPages - 1) {
      pageIndex.value++;
      pageController.animateToPage(
        pageIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      completeOnboarding();
    }
  }

  void skip() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('seenOnboarding', true);
      Get.offAllNamed(AppRoutes.selectUserScreen);
    } catch (e) {
      debugPrint("Error saving onboarding status: $e");
      // Optionally handle the error, e.g., show a Snackbar
    }
  }

  @override
  void onClose() {
    pageController.dispose(); // prevent memory leaks
    super.onClose();
  }
}
