import 'dart:convert';

import 'package:cleaning_app/app/data/models/get_notification_model.dart';
import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_snackbar.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnnouncementScreenController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotificationApi();
  }

  // Sample notification data
  var notifications = <Map<String, dynamic>>[
    {
      'id': '1',
      'title': 'New Booking Received',
      'message':
          'You have received a new cleaning booking for tomorrow at 10:00 AM',
      'type': 'booking',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 15)),
      'isRead': false,
      'icon': Icons.work,
      'color': Colors.blue,
    },
    {
      'id': '2',
      'title': 'Payment Processed',
      'message': 'Your payment of ₹1,500 has been successfully processed',
      'type': 'payment',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': false,
      'icon': Icons.payment,
      'color': Colors.green,
    },
    {
      'id': '3',
      'title': 'Customer Review',
      'message': 'Sarah Johnson left a 5-star review for your cleaning service',
      'type': 'review',
      'timestamp': DateTime.now().subtract(const Duration(hours: 4)),
      'isRead': true,
      'icon': Icons.star,
      'color': Colors.orange,
    },
    {
      'id': '4',
      'title': 'App Update Available',
      'message':
          'A new version of the app is available. Update now for better performance',
      'type': 'system',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': true,
      'icon': Icons.system_update,
      'color': Colors.purple,
    },
    {
      'id': '5',
      'title': 'Booking Reminder',
      'message':
          'You have a cleaning appointment in 30 minutes at 123 Main Street',
      'type': 'reminder',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      'isRead': true,
      'icon': Icons.schedule,
      'color': Colors.red,
    },
    {
      'id': '6',
      'title': 'Profile Verification',
      'message':
          'Your profile has been successfully verified by our admin team',
      'type': 'verification',
      'timestamp': DateTime.now().subtract(const Duration(days: 3)),
      'isRead': true,
      'icon': Icons.verified,
      'color': Colors.teal,
    },
    {
      'id': '7',
      'title': 'Weekly Earnings',
      'message': 'Your weekly earnings summary: ₹8,500 from 12 completed jobs',
      'type': 'earnings',
      'timestamp': DateTime.now().subtract(const Duration(days: 4)),
      'isRead': true,
      'icon': Icons.account_balance_wallet,
      'color': Colors.indigo,
    },
    {
      'id': '8',
      'title': 'Equipment Request',
      'message':
          'Your equipment request has been approved. Pick up from office tomorrow',
      'type': 'equipment',
      'timestamp': DateTime.now().subtract(const Duration(days: 5)),
      'isRead': true,
      'icon': Icons.build,
      'color': Colors.brown,
    },
  ].obs;

  final Rx<NotificationModel?> notificationData = Rx<NotificationModel?>(null);


  final dio = Dio(
    BaseOptions(
      baseUrl: AppUrl.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );


  Future<void> getNotificationApi() async {
    isLoading.value = true;

    try {
      final userId = AppLocalStorage.getUserId();
      final token = AppLocalStorage.getToken();
      // Replace this with your actual API endpoint
      final url = Uri.parse('${AppUrl.getNotification}?user_id=$userId');

      // Optional headers (e.g., if you have token authentication)
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}', // if needed
      };

      final response = await http.get(url, headers: headers);

      print("📡 Home API URL: $url");
      print("📩 Status Code: ${response.statusCode}");
      print("📨 Response: ${response.body}");
      final data = json.decode(response.body);
      print("data data is here :${data}");
      if (response.statusCode == 200) {
        if (data['status'] == true || data['success'] == true) {

          final responseBody = jsonDecode(response.body);
          final NotificationModel notificationModel = NotificationModel.fromJson(responseBody);

          notificationData.value = notificationModel;

          print("message is here${data['data']}");

        } else {
          Get.snackbar('Error', 'Failed to fetch home details: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSingleNotificationApi(String notificationId) async {
    isLoading.value = true;

    try {
      final userId = AppLocalStorage.getUserId();
      final token = AppLocalStorage.getToken();
      final url = Uri.parse('${AppUrl.baseUrl}/delete_single_notification');

      final body = jsonEncode({
        'user_id': userId,
        'notification_message_id': notificationId,
      });

      // Headers
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token', // if needed
      };

      final response = await http.post(url, headers: headers, body: body);

      print("📡 Delete Notification API URL: $url");
      print("📨 Request Body: $body");
      print("📩 Status Code: ${response.statusCode}");
      print("📨 Response: ${response.body}");

      final data = json.decode(response.body);

      if (response.statusCode == 200) {

        if (data['status'] == true || data['success'] == true) {

          Get.snackbar('Success', data['message'] ?? 'Notification deleted successfully');
        } else {
          Get.snackbar('Error', data['message'] ?? 'Failed to delete notification');
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      print("Delete Notification Exception: $e");
      Get.snackbar('Error', 'Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAllNotificationsApi() async {
    isLoading.value = true;

    try {
      final userId = AppLocalStorage.getUserId();
      final token = AppLocalStorage.getToken();
      final url = Uri.parse(AppUrl.deleteSingleNotification);

      final body = jsonEncode({
        'user_id': userId,
      });

      // Headers
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token', // if needed
      };

      final response = await http.post(url, headers: headers, body: body);

      print("📡 Delete Notification API URL: $url");
      print("📨 Request Body: $body");
      print("📩 Status Code: ${response.statusCode}");
      print("📨 Response: ${response.body}");

      final data = json.decode(response.body);

      if (response.statusCode == 200) {

        if (data['status'] == true || data['success'] == true) {

          Get.snackbar('Success', data['message'] ?? 'Notification deleted successfully');
        } else {
          Get.snackbar('Error', data['message'] ?? 'Failed to delete notification');
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      print("Delete Notification Exception: $e");
      Get.snackbar('Error', 'Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }


  int get unreadCount {
    return notifications.where((n) => !n['isRead']).length;
  }

  String formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void markAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n['id'] == notificationId);
    if (index != -1) {
      notifications[index]['isRead'] = true;
    }
  }

  void markAllAsRead() {
    for (var notification in notifications) {
      notification['isRead'] = true;
    }
  }

  void clearAllNotifications() {
    notifications.clear();
  }

  Future<void> showDeleteAllDialog(BuildContext context, AnnouncementScreenController controller) async {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.redAccent,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Title
              Text(
                "Delete All Notifications?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColours.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              const SizedBox(height: 10),

              // 🔹 Subtitle
              Text(
                "This action cannot be undone. Are you sure you want to delete all your notifications?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontFamily: AppFonts.fontFamily,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              // 🔹 Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(), // dismiss dialog
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.back(); // Close dialog
                        // await controller.deleteAllNotificationsApi(); // Call delete API
                        controller.notificationData.value?.notificationArr?.clear();
                        controller.notificationData.refresh();

                        Get.snackbar(
                          "Deleted",
                          "All notifications deleted successfully",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent.withOpacity(0.8),
                          colorText: Colors.white,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Delete All",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}


