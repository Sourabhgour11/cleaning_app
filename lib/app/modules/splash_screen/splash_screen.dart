import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cleaning_app/app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/home_screen/home_screen.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _locationReady = false;
  bool _sessionChecked = false;
  bool _isLoggedIn = false;
  var check;
  var appStatus;

  @override
  void initState() {
    super.initState();
    _initializeApp();
    checkFirstTimeInstall();
  }

  checkFirstTimeInstall() async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    appStatus = prefs.getInt("appStatus");
    print("${appStatus} appstatus is here");

  }

  Future<void> _initializeApp() async {
    await _initLocationPermission();
    await _checkSession();
    setState(() {
      _sessionChecked = true;
    });
    final token = AppLocalStorage.getToken();
    print('User token: $token');
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

  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print("${token}token is here");
    if (token != null && token.isNotEmpty) {
      debugPrint("🔑 User logged in with token: $token");
      _isLoggedIn = true;
    } else {
      debugPrint("🚫 No user session found");
      _isLoggedIn = false;
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    // While waiting for both location and session checks to complete
    if (!_locationReady || !_sessionChecked) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.cover,
              onError: (error, stackTrace) {
                debugPrint('❌ Failed to load background image: $error');
              },
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      );
    }

    // Once everything is ready, show the animated splash
    return Scaffold(
      body: AnimatedSplashScreen(
        duration: 2000,
        splash: Transform.scale(
          scale: 3.0,
          child: Image.asset(
            AppImages.splashIcon,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('❌ Failed to load splash image: $error');
              // Fallback to a default widget if the image fails to load
              return const FlutterLogo(size: 120);
            },
          ),
        ),
        // nextScreen: _isLoggedIn
        //     ?  UserBottomNavScreen()
        //     :  LoginScreen(),

        nextScreen:
         (appStatus==1) ?  _isLoggedIn?UserBottomNavScreen()
            :  LoginScreen():OnboardingScreen(),

        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      ),
    );
  }

}
