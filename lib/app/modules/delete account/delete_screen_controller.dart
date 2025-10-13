import 'package:cleaning_app/app/utils/app_export.dart';

class DeleteScreenController extends GetxController {
  // Observable variables
  var selectedReason = ''.obs;
  var otherReason = ''.obs;
  var isAgreed = false.obs;
  var isProcessing = false.obs;

  // Delete reasons
  var deleteReasons = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeReasons();
  }

  void _initializeReasons() {
    deleteReasons.value = [
      {
        'title': 'Found another job',
        'icon': Icons.work,
        'value': 'another_job',
      },
      {
        'title': 'Not getting enough jobs',
        'icon': Icons.work_off,
        'value': 'not_enough_jobs',
      },
      {
        'title': 'Service fees are too high',
        'icon': Icons.money_off,
        'value': 'high_fees',
      },
      {
        'title': 'App is difficult to use',
        'icon': Icons.phone_android,
        'value': 'difficult_app',
      },
      {
        'title': 'Poor customer support',
        'icon': Icons.support_agent,
        'value': 'poor_support',
      },
      {
        'title': 'Privacy concerns',
        'icon': Icons.privacy_tip,
        'value': 'privacy',
      },
      {
        'title': 'Taking a break',
        'icon': Icons.pause_circle,
        'value': 'taking_break',
      },
      {'title': 'Other reason', 'icon': Icons.more_horiz, 'value': 'other'},
    ];
  }

  void selectReason(String reason) {
    selectedReason.value = reason;
  }

  void toggleAgreement() {
    isAgreed.value = !isAgreed.value;
    print(isAgreed.value);
  }

  bool canProceed() {
    // Check if either a reason is selected OR other reason text is provided
    bool hasReason =
        selectedReason.value.isNotEmpty || otherReason.value.trim().isNotEmpty;
    return hasReason && isAgreed.value;
  }

  void showFinalConfirmation() {
    if (!canProceed()) {
      Get.snackbar(
        'Incomplete Information',
        'Please provide a reason and agree to the terms',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
            const SizedBox(width: 12),
            const Text(
              'Final Confirmation',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This is your last chance!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              'Once you confirm, your account will be permanently deleted and you will lose:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            _buildLossItem('All your profile information'),
            _buildLossItem('Your earnings history'),
            _buildLossItem('Your ratings and reviews'),
            _buildLossItem('Access to pending payments'),
            _buildLossItem('All job history'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: const Text(
                'This action is IRREVERSIBLE!',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _deleteAccount();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete My Account'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildLossItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.close, color: Colors.red, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  void _deleteAccount() {
    isProcessing.value = true;

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      isProcessing.value = false;

      Get.dialog(
        AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 12),
              Text('Account Deleted'),
            ],
          ),
          content: const Text(
            'Your account has been successfully deleted. We\'re sorry to see you go and hope to serve you again in the future.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close dialog
                Get.offAllNamed(AppRoutes.selectUserScreen);
                Get.snackbar(
                  'Goodbye',
                  'Your account has been deleted',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              child: const Text('Close'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    });
  }

  void showAlternativeOptions() {
    Get.dialog(
      AlertDialog(
        title: const Text('Before You Go...'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Consider these alternatives:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildAlternativeItem(
              'Deactivate Temporarily',
              'Take a break without losing your data',
              Icons.pause_circle_outline,
            ),
            const SizedBox(height: 12),
            _buildAlternativeItem(
              'Contact Support',
              'Let us help resolve your concerns',
              Icons.support_agent,
            ),
            const SizedBox(height: 12),
            _buildAlternativeItem(
              'Update Settings',
              'Customize your experience',
              Icons.settings,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Continue Deletion'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Contact Support',
                'Opening support...',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Contact Support'),
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeItem(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
