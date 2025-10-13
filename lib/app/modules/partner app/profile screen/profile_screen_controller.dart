import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../rotes/app_routes.dart';
import '../../../utils/app_images.dart';

class ProfileScreenController extends GetxController {
  var isLoading = false.obs;
  var isEditing = false.obs;

  // Profile data
  var profileData = {
    'name': 'John Smith',
    'email': 'john.smith@email.com',
    'phone': '+91 98765 43210',
    'address': '123 Main Street, Downtown, City',
    'experience': '3 years',
    'rating': 4.8,
    'totalJobs': 156,
    'completedJobs': 142,
    'cancelledJobs': 14,
    'totalEarnings': 125000,
    'profileImage': AppImages.profileImage,
    'isVerified': true,
    'joinDate': '2021-01-15',
    'languages': ['English', 'Hindi', 'Tamil'],
    'specialties': ['Deep Cleaning', 'Office Cleaning', 'Post-Construction'],
    'availability': 'Available',
    'workingHours': '9:00 AM - 6:00 PM',
  }.obs;

  // Menu items
  var menuItems = [
    {
      'title': 'Edit Profile',
      'icon': Icons.edit,
      'color': Colors.blue,
      'action': 'edit_profile',
    },
    // {
    //   'title': 'Settings',
    //   'icon': Icons.settings,
    //   'color': Colors.grey,
    //   'action': 'settings',
    // },
    {
      'title': 'Incentive',
      'icon': Icons.payment,
      'color': Colors.green,
      'action': 'incentive',
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
      'color': Colors.blue,
      'action': 'about',
    },
    {
      'title': 'Delete Account',
      'icon': Icons.delete_forever,
      'color': Colors.red,
      'action': 'delete account',
    },
    {
      'title': 'Logout',
      'icon': Icons.logout,
      'color': Colors.red,
      'action': 'logout',
    },
  ].obs;

  void toggleEditMode() {
    isEditing.value = !isEditing.value;
  }

  void updateProfile(String field, String value) {
    profileData[field] = value;
  }

  void saveProfile() {
    // Save profile logic here
    isEditing.value = false;
    Get.snackbar(
      'Success',
      'Profile updated successfully!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void handleMenuAction(String action) {
    switch (action) {
      case 'edit_profile':
        Get.toNamed(AppRoutes.editProfile);
        break;
      case 'settings':
        Get.snackbar('Settings', 'Settings screen coming soon!');
        break;
      case 'incentive':
        Get.toNamed(AppRoutes.incentive);
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
      case 'delete account':
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

  String formatCurrency(int amount) {
    return '₹${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  String formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.day}/${date.month}/${date.year}';
  }
}
