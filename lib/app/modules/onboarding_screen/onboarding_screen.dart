import 'package:cleaning_app/app/modules/onboarding_screen/onboarding_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';
import 'package:cleaning_app/app/utils/app_images.dart';
import 'package:cleaning_app/app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final controller = Get.put(OnboardingScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 100 / 100,
        width: MediaQuery.of(context).size.width * 100 / 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) => controller.pageIndex.value = index,
                itemCount: controller.onboardingData.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        controller.onboardingData[index]['image']!,
                        height: 300,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        controller.onboardingData[index]['title']!,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.bold,
                          color: AppColours.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          controller.onboardingData[index]['subtitle']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.fontFamily,
                            color: AppColours.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Page indicators
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(controller.onboardingData.length, (
                  index,
                ) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: controller.pageIndex.value == index ? 20 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: controller.pageIndex.value == index
                          ? AppColours.white
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            // Skip & Next buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: controller.skip,
                    child: const Text(
                      AppStrings.skip,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: AppFonts.fontFamily,
                        color: AppColours.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: controller.nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColours.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(AppStrings.next),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
