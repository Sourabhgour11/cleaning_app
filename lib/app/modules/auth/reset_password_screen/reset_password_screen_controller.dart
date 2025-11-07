import 'package:cleaning_app/app/utils/app_export.dart';

class ResetPasswordScreenController extends GetxController {
  // Controllers
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;

  // Focus Nodes
  final newPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  // Observable Variables
  RxBool isLoading = false.obs;
  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  @override
  void onClose() {
    newPasswordController.value.dispose();
    confirmPasswordController.value.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Reset password function
  void resetPassword() {
    final newPassword = newPasswordController.value.text;
    final confirmPassword = confirmPasswordController.value.text;

    // Validation
    if (newPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a new password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Please confirm your password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Start loading
    isLoading.value = true;

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      // Show success message
      Get.snackbar(
        'Success',
        'Password reset successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate back to login
      Get.back();
    });
  }
}
