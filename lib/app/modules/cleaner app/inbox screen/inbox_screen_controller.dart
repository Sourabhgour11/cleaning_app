import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InboxScreenController extends GetxController {
  var isLoading = false.obs;
  var messageController = TextEditingController();
  var scrollController = ScrollController();
  var isTyping = false.obs;
  var adminIsOnline = true.obs;

  // Sample chat messages
  var messages = <Map<String, dynamic>>[
    {
      'id': '1',
      'text':
          'Hello! Welcome to CleanPro. I\'m here to help you with any questions or issues.',
      'isFromAdmin': true,
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': true,
    },
    {
      'id': '2',
      'text':
          'Thank you! I just completed my first cleaning job. How do I get paid?',
      'isFromAdmin': false,
      'timestamp': DateTime.now().subtract(
        const Duration(hours: 1, minutes: 30),
      ),
      'isRead': true,
    },
    {
      'id': '3',
      'text':
          'Great job! Payments are processed automatically after job completion. You\'ll receive your payment within 24-48 hours in your registered bank account.',
      'isFromAdmin': true,
      'timestamp': DateTime.now().subtract(
        const Duration(hours: 1, minutes: 25),
      ),
      'isRead': true,
    },
    {
      'id': '4',
      'text':
          'I have a question about the cleaning supplies. Do I need to bring my own?',
      'isFromAdmin': false,
      'timestamp': DateTime.now().subtract(const Duration(minutes: 45)),
      'isRead': true,
    },
    {
      'id': '5',
      'text':
          'No, you don\'t need to bring your own supplies. We provide all necessary cleaning equipment and supplies. You can pick them up from our office or we can deliver them to your location.',
      'isFromAdmin': true,
      'timestamp': DateTime.now().subtract(const Duration(minutes: 40)),
      'isRead': true,
    },
    {
      'id': '6',
      'text': 'Perfect! What time can I pick up the supplies?',
      'isFromAdmin': false,
      'timestamp': DateTime.now().subtract(const Duration(minutes: 35)),
      'isRead': false,
    },
  ].obs;

  // Recent conversations
  var recentConversations = <Map<String, dynamic>>[
    {
      'id': '1',
      'name': 'Admin Support',
      'lastMessage': 'Perfect! What time can I pick up the supplies?',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 35)),
      'unreadCount': 0,
      'isOnline': true,
      'avatar': 'A',
    },
    {
      'id': '2',
      'name': 'Payment Team',
      'lastMessage': 'Your payment of ₹1,500 has been processed',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'unreadCount': 0,
      'isOnline': false,
      'avatar': 'P',
    },
    {
      'id': '3',
      'name': 'Technical Support',
      'lastMessage': 'App update available. Please update to latest version.',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'unreadCount': 1,
      'isOnline': true,
      'avatar': 'T',
    },
  ].obs;

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    final newMessage = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'text': messageController.text.trim(),
      'isFromAdmin': false,
      'timestamp': DateTime.now(),
      'isRead': false,
    };

    messages.add(newMessage);
    messageController.clear();

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Simulate admin typing
    _simulateAdminTyping();
  }

  void _simulateAdminTyping() {
    isTyping.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      isTyping.value = false;

      // Add admin response
      final adminResponse = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'text':
            'Our office is open from 9 AM to 6 PM. You can pick up supplies anytime during these hours.',
        'isFromAdmin': true,
        'timestamp': DateTime.now(),
        'isRead': false,
      };

      messages.add(adminResponse);

      // Scroll to bottom
      Future.delayed(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  void markAsRead(String messageId) {
    final messageIndex = messages.indexWhere((msg) => msg['id'] == messageId);
    if (messageIndex != -1) {
      messages[messageIndex]['isRead'] = true;
    }
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

  String formatMessageTime(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void onInit() {
    super.onInit();
    // Mark all messages as read when screen opens
    for (var message in messages) {
      message['isRead'] = true;
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
