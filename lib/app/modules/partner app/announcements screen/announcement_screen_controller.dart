import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AnnouncementScreenController extends GetxController {
  var isLoading = false.obs;

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
}
