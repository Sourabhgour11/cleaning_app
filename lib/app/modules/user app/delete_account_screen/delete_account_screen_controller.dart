import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountScreenController extends GetxController {
  var userEmail = 'user@example.com'.obs;
  final reasonController = TextEditingController();

  void confirmDelete() {
    if (reasonController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please provide a reason before deleting your account.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // Show confirmation dialog
    Get.defaultDialog(
      title: 'Confirm Delete',
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.redAccent,
      ),
      middleText:
      'Are you sure you want to delete your account?\nThis action cannot be undone.',
      middleTextStyle: const TextStyle(fontSize: 16),
      textCancel: 'Cancel',
      cancelTextColor: Colors.black,
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      buttonColor: Colors.redAccent,
      radius: 10,
      onConfirm: () {
        Get.back(); // close dialog
        deleteAccount();
      },
    );
  }

  void deleteAccount() {
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: Colors.redAccent)),
      barrierDismissible: false,
    );

    // Simulate delete action
    Future.delayed(const Duration(seconds: 2), () {
      Get.back(); // close loader
      Get.snackbar(
        'Account Deleted',
        'Your account has been deleted successfully.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }
}
