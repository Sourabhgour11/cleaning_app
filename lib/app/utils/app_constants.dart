import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:flutter/foundation.dart';

import 'app_local_storage.dart';

class AppConstants {
  static const String appName = 'CleanPro';
  static const String userType = '1';
  
  static const String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static final String deviceType = _getDeviceType();
  static final String playerId= '1234567890';
  static final String currency = 'ADE ';
  static final String mapApiKey= 'AIzaSyBu_hPjmC3jAI9s0wVqyRc03AWS4p0OLxc';

  static String? userName;
  static String? userEmail;
  static String? userMobile;
  static String? address;

  static RxInt? bottomNavIndex = 0.obs;

  // static final String mapApiKey= 'AIzaSyBu_hPjmC3jAI9s0wVqyRc03AWS4p0OLxc';

  static Future<void> loadUserDetails() async {
    final userData = await AppLocalStorage.getUserDetails();
    userName = userData?['name'];
    userEmail = userData?['email'];
    userMobile = userData?['mobile'];
    address = userData?['address'];
  }

  //JMS STORE MAPKEY
  // static final String mapApiKey= 'AIzaSyAxMOX-lzwAf0cP6KwA0CroEgNfNFvOlKg';

  
  static String _getDeviceType() {
    if (kIsWeb) {
      return 'web';
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return 'android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'ios';
    } else {
      return 'unknown';
    }
  }
}
