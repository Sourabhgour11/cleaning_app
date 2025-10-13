import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../announcements screen/announcement_screen.dart';
import '../home screen/home_screen.dart';
import '../profile screen/profile_screen.dart';

class PartnerBottomNavController extends GetxController {
  // Selected index observable
  var selectedIndex = 0.obs;

  // Screens list
  final List<Widget> screens = [
    PartnerHomeScreen(),
    AnnouncementScreen(),
    ProfileScreen(),
  ];

  // Change tab
  void onTabChanged(int index) {
    selectedIndex.value = index;
  }
}
