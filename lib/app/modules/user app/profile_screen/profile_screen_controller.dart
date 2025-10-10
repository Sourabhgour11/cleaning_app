import 'package:get/get.dart';

class ProfileController extends GetxController {
  var userName = 'Sourabh'.obs;
  var phoneNumber = '+918120527453'.obs;

  void onLogout() {
    // Handle logout logic here
    Get.snackbar('Logout', 'You have logged out successfully');
  }
}
