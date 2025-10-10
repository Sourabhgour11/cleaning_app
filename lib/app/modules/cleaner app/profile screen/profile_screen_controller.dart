import 'package:get/get.dart';
import 'package:flutter/material.dart';
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
      'title': 'Terms of Service',
      'icon': Icons.description,
      'color': Colors.indigo,
      'action': 'terms',
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
        toggleEditMode();
        break;
      case 'settings':
        Get.snackbar('Settings', 'Settings screen coming soon!');
        break;
      case 'incentive':
        Get.snackbar('Incentive', 'Incentive methods screen coming soon!');
        break;
      case 'help':
        Get.snackbar('Help', 'Help & Support screen coming soon!');
        break;
      case 'privacy':
        Get.snackbar('Privacy', 'Privacy Policy screen coming soon!');
        break;
      case 'terms':
        Get.snackbar('Terms', 'Terms of Service screen coming soon!');
        break;
      case 'logout':
        _showLogoutDialog();
        break;
    }
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Logout', 'Logged out successfully!');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  String formatCurrency(int amount) {
    return '₹${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  String formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.day}/${date.month}/${date.year}';
  }
}
