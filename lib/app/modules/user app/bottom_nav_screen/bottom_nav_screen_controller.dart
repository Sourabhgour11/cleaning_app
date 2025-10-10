import 'package:cleaning_app/app/modules/user%20app/booking_screen/booking_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/home_screen/home_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/profile_screen/profile_screen.dart';
import 'package:cleaning_app/app/modules/user%20app/wallet_screen/wallet_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class BottomNavController extends GetxController {
  // Selected index observable
  var selectedIndex = 0.obs;

  // Screens list
  final List<Widget> screens = [
    HomeScreen(),
    BookingScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  // Change tab
  void onTabChanged(int index) {
    selectedIndex.value = index;
  }
}
