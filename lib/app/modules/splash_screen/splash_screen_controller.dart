import 'dart:async';

import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {

  void onReady() {
    super.onReady();

    // Timer(const Duration(seconds: 2), () async {
    //   final prefs = await SharedPreferences.getInstance();
    //   bool seen = prefs.getBool('seenOnboarding') ?? false;
    //
    //   if (seen) {
    //     Get.offAllNamed(AppRoutes.home);
    //   } else {
    //     Get.offAllNamed(AppRoutes.onboarding);
    //   }
    // });
  }
}
