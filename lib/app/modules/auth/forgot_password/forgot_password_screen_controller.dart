import '../../../utils/app_export.dart';

class ForgotPasswordScreenController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  final FocusNode emailFocusNode = FocusNode();

  void sendResetEmail() {
    if (emailController.value.text.isNotEmpty) {
      isLoading.value = true;

      Get.toNamed(AppRoutes.forgotOtp);
      emailController.value.clear();
      emailFocusNode.unfocus();
      isLoading.value = false;
    }
  }
}
