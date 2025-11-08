import 'package:flutter/foundation.dart';

class AppConstants {
  static const String appName = 'CleanPro';
  static const String userType = '1';
  
  static const String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static final String deviceType = _getDeviceType();
  static final String playerId= '1234567890';
  static final String mapApiKey= 'AIzaSyBu_hPjmC3jAI9s0wVqyRc03AWS4p0OLxc';

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
