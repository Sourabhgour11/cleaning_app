import 'package:cleaning_app/app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceItem {
  final String name;
  final IconData icon;
  ServiceItem({required this.name, required this.icon});
}

class HomeScreenController extends GetxController {
  var userName = 'Sourabh'.obs;
  var location = '1302, Nehru place, Jumeirah Beach Residence'.obs;
  var currentIndex = 0.obs;
  var images = [
    AppImages.vaccumOnboardingImage,
    AppImages.vaccumOnboardingImage,
    AppImages.vaccumOnboardingImage,
  ];
  var services = [
    ServiceItem(name: 'General Cleaning', icon: Icons.cleaning_services),
    ServiceItem(name: 'Cleaning Subscription', icon: Icons.calendar_month),
    ServiceItem(name: 'Salon & Spa', icon: Icons.brush),
    ServiceItem(name: 'Handyman', icon: Icons.handyman),
    ServiceItem(name: 'Health', icon: Icons.health_and_safety),
  ];
}
