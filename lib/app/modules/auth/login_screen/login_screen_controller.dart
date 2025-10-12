import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  var userType = '';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    userType = Get.arguments;
    print("userType: $userType");
  }

  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    if (email.isNotEmpty && password.isNotEmpty) {
      print("Email And Password Is Not Empty");
      isLoading.value = false;
    } else if (userType == AppStrings.cleaner) {
      isLoading.value = false;
      print("User Type Is Cleaner");
      Get.offAllNamed(AppRoutes.bottomNav);
    } else if (userType == AppStrings.user) {
      Get.offAllNamed(AppRoutes.bottomNav);
      isLoading.value = false;
      print("User Type Is User");
    } else {
      Get.snackbar('Error', AppStrings.invalidCredentials);
      isLoading.value = false;
    }

    isLoading.value = false;
  }
}
