import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cleaning_app/app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: AppStyle.screenHeight(context),
        width: AppStyle.screenWidth(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: AnimatedSplashScreen(
          duration: 2000,
          splash: Transform.scale(
            scale: 3.0, // Increase the size of the logo
            child: Image.asset(AppImages.splashIcon, fit: BoxFit.contain),
          ),
          nextScreen: OnboardingScreen(),
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
