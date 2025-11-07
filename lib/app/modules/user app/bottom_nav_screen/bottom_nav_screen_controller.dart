import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cleaning_app/app/modules/user app/home_screen/home_screen.dart';
import 'package:cleaning_app/app/modules/user app/booking_screen/booking_screen.dart';
import 'package:cleaning_app/app/modules/user app/wallet_screen/wallet_screen.dart';
import 'package:cleaning_app/app/modules/user app/profile_screen/profile_screen.dart';

class UserBottomNavController extends GetxController {
  // Selected tab index
  var selectedIndex = 0.obs;

  // Screens for each tab
  final List<Widget> screens = [
    HomeScreen(),
    UserBookingScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  // Change selected tab
  void onTabChanged(int index) {
    selectedIndex.value = index;
  }
}
