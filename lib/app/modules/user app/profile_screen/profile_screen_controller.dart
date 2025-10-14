import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step_4/book_service_step4_screen_controller.dart';
import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  var userName = 'Sourabh'.obs;
  var phoneNumber = '+918120527453'.obs;
  var appBarTitle = 'Payment Mehthod'.obs;

  var profileData = {
    'name': 'Sourabh',
    'email': 'sourabh@email.com',
    'phone': '+918120527453',
    'address': '123 Main Street, Downtown, City',
    'totalBookings': 24,
    'favorites': 8,
    'cancelledBookings': 2,
    'totalSpent': 12500,
    'profileImage': 'assets/images/profile.png',
    'isVerified': true,
    'joinDate': '2023-01-15',
    'userType': 'Premium User',
    'rating': 4.9,
  }.obs;

  // Menu items
  var menuItems = [
    {
      'title': 'Edit Profile',
      'icon': Icons.edit,
      'color': Colors.blue,
      'action': 'edit_profile',
    },
    {
      'title': 'Favorites',
      'icon': Icons.favorite,
      'color': Colors.red,
      'action': 'favorites',
    },
    {
      'title': 'Payment Methods',
      'icon': Icons.credit_card,
      'color': Colors.green,
      'action': 'payment_methods',
    },
    {
      'title': 'Help & Support',
      'icon': Icons.help_outline,
      'color': Colors.orange,
      'action': 'help',
    },
    {
      'title': 'Privacy Policy',
      'icon': Icons.privacy_tip,
      'color': Colors.purple,
      'action': 'privacy',
    },
    {
      'title': 'Terms & Condition',
      'icon': Icons.description,
      'color': Colors.indigo,
      'action': 'terms',
    },
    {
      'title': 'About Us',
      'icon': Icons.info,
      'color': Colors.indigo,
      'action': 'about',
    },
    {
      'title': 'Delete Account',
      'icon': Icons.delete_forever,
      'color': Colors.red,
      'action': 'delete_account',
    },
    {
      'title': 'Logout',
      'icon': Icons.logout,
      'color': Colors.red,
      'action': 'logout',
    },
  ].obs;

  void onLogout() {
    // Handle logout logic here
    Get.offAllNamed(AppRoutes.selectUserScreen);
    Get.snackbar('Logout', 'You have logged out successfully');
  }

  void handleMenuAction(String action) {
    switch (action) {
      case 'edit_profile':
        Get.toNamed(AppRoutes.editProfile);
        break;
      case 'favorites':
        Get.toNamed(AppRoutes.favourite);
        break;
      case 'payment_methods':
        Get.delete<BookServiceStep4ScreenController>();
        Get.toNamed(AppRoutes.bookServiceStep4,arguments: appBarTitle);
        break;
      case 'help':
        Get.toNamed(AppRoutes.helpAndSupport);
        break;
      case 'privacy':
        Get.toNamed(AppRoutes.getContent, arguments: {'type': 'privacy'});
        break;
      case 'terms':
        Get.toNamed(AppRoutes.getContent, arguments: {'type': 'terms'});
        break;
      case 'about':
        Get.toNamed(AppRoutes.getContent, arguments: {'type': 'about'});
        break;
      case 'delete_account':
        Get.toNamed(AppRoutes.deleteAccount);
        break;
      case 'logout':
        showLogoutDialog();
        break;
    }
  }

  void showLogoutDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔴 Logout Icon
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),

              // 🔤 Title
              const Text(
                "Logout",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // 💬 Subtitle
              const Text(
                "Are you sure you want to logout?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),

              const SizedBox(height: 25),

              // 🧭 Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Confirm Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        logoutUser();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // user must choose
    );
  }

  void logoutUser() {
    // Add your logout logic here (e.g. clearing storage, navigating to login)
    Get.offAllNamed(AppRoutes.selectUserScreen);
    Get.snackbar(
      "Logged out",
      "You have been successfully logged out.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.2),
      colorText: Colors.red,
    );
    // Example navigation:
    // Get.offAllNamed('/login');
  }
}
