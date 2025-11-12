import 'package:cleaning_app/app/modules/user%20app/announcement_screen/announcement_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/booking_screen/booking_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/home_screen/home_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/profile_screen/profile_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/wallet_screen/wallet_screen.dart';
import 'package:cleaning_app/app/utils/app_constants.dart';
import 'package:cleaning_app/app/utils/app_export.dart';

class UserBottomNavController extends GetxController {
  // Always start at first tab
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Ensure index is reset whenever controller is created
    _resetBottomNav();
  }

  void _resetBottomNav() {
    selectedIndex.value = 0; // Home tab
    AppConstants.bottomNavIndex?.value = 0; // optional: reset global
  }

  // Screens for each tab
  final List<Widget> screens = [
    HomeScreen(),
    UserBookingScreen(),
    WalletScreen(),
    AnnouncementScreen(),
    ProfileScreen(),
  ];

  // Change selected tab
  void onTabChanged(int index) {
    selectedIndex.value = index;
    AppConstants.bottomNavIndex?.value = index; // optional: save last index
  }
}
