import '../../../utils/app_export.dart';

class OtpScreenController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;
  final FocusNode otpFocusNode = FocusNode();
}
