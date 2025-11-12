import 'dart:convert';

import 'package:cleaning_app/app/data/models/get_content_model.dart';
import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step4/book_service_step4_screen_controller.dart';
import 'package:cleaning_app/app/modules/user%20app/bottom_nav_screen/bottom_nav_screen_controller.dart';
import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var userName = 'Sourabh'.obs;
  var phoneNumber = '+918120527453'.obs;
  var appBarTitle = 'Payment Mehthod'.obs;
  RxBool isLoading = false.obs;
  var htmlContent = ''.obs;
  dynamic userData;
  // var userName


  final Rx<GetContentModel?> getContentModel = Rx<GetContentModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getContentApi();
  }

  // Future<void> getContentApi() async {
  //   isLoading.value = true;
  //
  //   try {
  //     final userId = AppLocalStorage.getUserId();
  //     final token = AppLocalStorage.getToken();
  //     // TODO: Replace with actual wallet API endpoint when available
  //     // For now, using sample data structure
  //     final url = Uri.parse(AppUrl.getContent);
  //
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer ${token ?? ""}',
  //     };
  //
  //     final response = await http.get(url, headers: headers);
  //
  //     print("📡 Wallet API URL: $url");
  //     print("📩 Status Code: ${response.statusCode}");
  //     print("📨 Response: ${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       print("Get Content Data: $data");
  //
  //       if (data['status'] == true || data['success'] == true) {
  //         final responseBody = jsonDecode(response.body);
  //         getContentModel.value = GetContentModel.fromJson(responseBody);
  //
  //       } else {
  //         // If API fails, use sample data for development
  //         Get.snackbar('Info', 'Using sample wallet data. ${data['message'] ?? 'API not configured'}');
  //       }
  //     } else {
  //       // If API fails, use sample data for development
  //       Get.snackbar('Info', 'Using sample wallet data. API returned: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print("Wallet API Error: ${e.toString()}");
  //     // If API fails, use sample data for development
  //     Get.snackbar('Info', 'Using sample wallet data. Error: ${e.toString()}');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> getContentApi() async {
    try {

      isLoading.value = true;

      final response = await http.get(
        Uri.parse(AppUrl.getContent),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("${htmlContent.value} htmlgggg");

        if (data['success'] == true &&
            data['content_arr'] != null &&
            data['content_arr'].isNotEmpty) {
          htmlContent.value = data['content_arr'][0]['content'];
          print("✅ HTML Content Loaded Successfully");
        } else {
          htmlContent.value = "<p>No content found</p>";
        }
      } else {
        htmlContent.value = "<p>Failed to load content</p>";
      }
    } catch (e) {
      htmlContent.value = "<p>Error: $e</p>";
    } finally {
      isLoading.value = false;
    }
  }

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
    // {
    //   'title': 'Help & Support',
    //   'icon': Icons.help_outline,
    //   'color': Colors.orange,
    //   'action': 'help',
    // },
    {
      'title': 'Contact Us',
      'icon': Icons.phone,
      'color': Colors.orange,
      'action': 'contact_us',
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
      'title': 'Change Password',
      'icon': Icons.lock_person_sharp,
      'color': Colors.yellowAccent,
      'action': 'change password',
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

  void onLogout() async{
    // Handle logout logic here
    await AppLocalStorage.clearUserData();
    Get.offAllNamed(AppRoutes.login);
    Get.delete<UserBottomNavController>();

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
        Get.toNamed(AppRoutes.bookServiceStep4, arguments: appBarTitle);
        break;
      // case 'help':
      //   Get.toNamed(AppRoutes.helpAndSupport);
      //   break;
        case 'contact_us':
        Get.toNamed(AppRoutes.contactUs);
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
      case 'change password':
        Get.toNamed(AppRoutes.changePassword);
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

  void logoutUser() async{
    // Add your logout logic here (e.g. clearing storage, navigating to login)
    await AppLocalStorage.clearUserData();
    Get.offAllNamed(AppRoutes.login);
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
