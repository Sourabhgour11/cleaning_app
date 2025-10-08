import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // simulate API

    if (email == 'test@example.com' && password == '123456') {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar('Error', 'Invalid credentials');
    }

    isLoading.value = false;
  }
}
