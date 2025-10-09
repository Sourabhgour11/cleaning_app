import '../../../utils/app_export.dart';

class ForgotOtpScreenController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;
  final FocusNode otpFocusNode = FocusNode();
}
