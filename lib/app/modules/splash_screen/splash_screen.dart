import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cleaning_app/app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:cleaning_app/app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      splash: Transform.scale(
        scale: 3.0, // Increase the size of the logo
        child: Image.asset(
          AppImages.appLogo,
          fit: BoxFit.contain,
        ),
      ),
      nextScreen: OnboardingScreen(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.white,
      animationDuration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }
}
