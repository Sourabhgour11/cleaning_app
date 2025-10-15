import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cleaning_app/app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:geolocator/geolocator.dart';
import '../../utils/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _locationReady = false;

  @override
  void initState() {
    super.initState();
    _initLocationPermission();
  }

  Future<void> _initLocationPermission() async {
    await Future.delayed(const Duration(milliseconds: 500)); // small delay

    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("❌ Location service disabled");
      setState(() => _locationReady = true);
      return;
    }

    // Check and request permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("⚠️ Location permission permanently denied");
      setState(() => _locationReady = true);
      return;
    }

    debugPrint("✅ Location permission granted");
    setState(() => _locationReady = true);
  }

  @override
  Widget build(BuildContext context) {
    // Wait until location is ready, then show your splash animation
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
        child: _locationReady
            ? AnimatedSplashScreen(
                duration: 2000,
                splash: Transform.scale(
                  scale: 3.0,
                  child: Image.asset(AppImages.splashIcon, fit: BoxFit.contain),
                ),
                nextScreen: OnboardingScreen(),
                splashTransition: SplashTransition.scaleTransition,
                pageTransitionType: PageTransitionType.fade,
                backgroundColor: Colors.transparent,
                animationDuration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
