import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/modules/splash_screen/splash_screen.dart';
import 'app/utils/app_colours.dart';
import 'app/rotes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Home Cleaning User App',
      debugShowCheckedModeBanner: false,
      // initialBinding: InitialBinding(),
      home: const SplashScreen(), // ✅ start with splash
      getPages: AppPages.routes,
      theme: ThemeData(primaryColor: AppColours.appColor),
    );
  }
}
