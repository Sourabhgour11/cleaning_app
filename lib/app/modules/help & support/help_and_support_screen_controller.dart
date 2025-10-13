import 'package:get/get.dart';

class HelpAndSupportScreenController extends GetxController {
  // Observable variables
  var expandedFaqIndex = (-1).obs;
  
  // Support options
  var supportOptions = <Map<String, dynamic>>[].obs;
  
  // FAQ items
  var faqItems = <Map<String, dynamic>>[].obs;
  
  // Contact methods
  var contactMethods = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    // Support options
    supportOptions.value = [
      {
        'title': 'Chat Support',
        'subtitle': 'Get instant help',
        'icon': 'chat',
        'color': 'blue',
        'action': 'chat',
      },
      {
        'title': 'Call Us',
        'subtitle': 'Talk to our team',
        'icon': 'phone',
        'color': 'green',
        'action': 'call',
      },
      {
        'title': 'Email Support',
        'subtitle': 'Send us a message',
        'icon': 'email',
        'color': 'orange',
        'action': 'email',
      },
      {
        'title': 'FAQs',
        'subtitle': 'Find quick answers',
        'icon': 'faq',
        'color': 'purple',
        'action': 'faq',
      },
    ];

    // FAQ items
    faqItems.value = [
      {
        'question': 'How do I update my profile information?',
        'answer': 'Go to your Profile screen and tap the edit icon. You can update your name, contact details, profile picture, and other information. Don\'t forget to save your changes.',
      },
      {
        'question': 'How are incentives calculated?',
        'answer': 'Incentives are based on your performance, including job completion rate, customer ratings, timeliness, and special bonuses. Check the Incentives screen for detailed breakdown.',
      },
      {
        'question': 'What should I do if I can\'t complete a job?',
        'answer': 'If you encounter any issues, immediately contact support through the app. Navigate to the job details and use the "Report Issue" button to notify us.',
      },
      {
        'question': 'How do I receive my payments?',
        'answer': 'Payments are processed weekly and deposited directly to your registered bank account. You can view your payment history in the Earnings section.',
      },
      {
        'question': 'How can I improve my ratings?',
        'answer': 'Focus on punctuality, thorough cleaning, professional communication, and attention to detail. High ratings unlock bonus opportunities and more job offers.',
      },
      {
        'question': 'What if a customer is not satisfied?',
        'answer': 'Contact support immediately if there\'s an issue. We\'ll help resolve any disputes. Document the work with photos if possible and maintain professional communication.',
      },
      {
        'question': 'How do I change my availability?',
        'answer': 'Go to Profile > Availability Settings. You can set your working hours, days off, and update your status (Available/Busy/Offline).',
      },
      {
        'question': 'Can I cancel an accepted job?',
        'answer': 'Cancellations should be avoided, but if necessary, contact support at least 4 hours before the scheduled time. Frequent cancellations may affect your ratings.',
      },
    ];

    // Contact methods
    contactMethods.value = [
      {
        'title': 'Customer Support',
        'value': '+1 (800) 123-4567',
        'icon': 'phone',
        'type': 'phone',
      },
      {
        'title': 'Email Us',
        'value': 'support@cleaningapp.com',
        'icon': 'email',
        'type': 'email',
      },
      {
        'title': 'Working Hours',
        'value': 'Mon-Fri: 8:00 AM - 8:00 PM',
        'icon': 'time',
        'type': 'info',
      },
      {
        'title': 'Emergency Support',
        'value': '24/7 Available',
        'icon': 'emergency',
        'type': 'info',
      },
    ];
  }

  void toggleFaq(int index) {
    if (expandedFaqIndex.value == index) {
      expandedFaqIndex.value = -1;
    } else {
      expandedFaqIndex.value = index;
    }
  }

  void handleSupportAction(String action) {
    switch (action) {
      case 'chat':
        Get.snackbar(
          'Chat Support',
          'Opening chat support...',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
      case 'call':
        Get.snackbar(
          'Call Support',
          'Calling support team...',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
      case 'email':
        Get.snackbar(
          'Email Support',
          'Opening email client...',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
      case 'faq':
        // Scroll to FAQ section
        Get.snackbar(
          'FAQs',
          'Scroll down to view frequently asked questions',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
    }
  }

  void handleContactMethod(String type, String value) {
    switch (type) {
      case 'phone':
        Get.snackbar(
          'Calling',
          'Opening phone dialer: $value',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
      case 'email':
        Get.snackbar(
          'Email',
          'Opening email client: $value',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
      default:
        break;
    }
  }
}