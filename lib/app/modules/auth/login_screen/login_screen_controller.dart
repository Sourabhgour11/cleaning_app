import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../utils/app_constants.dart';
import '../../../utils/app_export.dart';
import '../../../utils/app_local_storage.dart';
import '../../../utils/app_snackbar.dart';
import '../../../utils/app_url.dart';

class LoginScreenController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordVisible = true.obs;


  var isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login(String email, String password) async {
    print("Email: $email");
    print("Password: $password");
    isLoading.value = true;
    if (email.isEmpty || password.isEmpty) {
      print("Email And Password Is Not Empty");
      AppSnackbar.error(message: AppStrings.emailAndPasswordAreRequired);
      isLoading.value = false;
    } else if (!RegExp(AppConstants.emailRegex).hasMatch(email)) {
      AppSnackbar.error(message: AppStrings.invalidEmail);
      isLoading.value = false;
    } else if (password.length < 6) {
      AppSnackbar.error(message: AppStrings.passwordMustBeAtLeast6Characters);
      isLoading.value = false;
    } else {
      await loginApi(email, password, );
    }
  }

  Future<void> loginApi(email, password,) async {
    print("Login Api Calling...");
    try {
      // Create FormData
      var request = http.MultipartRequest('POST', Uri.parse(AppUrl.login));
      request.fields.addAll({
        'email': email,
        'password': password,
        'user_type': AppConstants.userType,
        'device_type': AppConstants.deviceType,
        'player_id': AppConstants.playerId,
      });

      var response = await request.send();
      print("Body : $response");

      // Read response body from StreamedResponse
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(responseBody);
        print("Data: $data");
        if (data['success'] == true) {
          isLoading.value = false;

          // Extract and save user data
          String? userId;
          String? token;
          Map<String, dynamic>? userDetails;

          if (data['userDataArray'] != null||data['userDataArray'].isNotEmpty) {
            print("Data : ${data['userDataArray']}");

              userDetails = data['userDataArray'];

              if (userDetails != null) {
                userId = userDetails['user_id']?.toString() ?? '';
              }

          }

          token = data['token']?.toString();

          // Save user data to local storage
          if (userId != null && token != null) {
            bool saved = await AppLocalStorage.saveUserData(
              userId: userId,
              token: token,
              userDetails: userDetails,
            );
            if (saved) {
              print("User data saved to local storage");

            }
          }
          AppSnackbar.success(message: data['msg'][0].toString());
          Get.offAllNamed(AppRoutes.userBottomNav);
        } else {
          print("Error: ${data['msg'][0]}");
          isLoading.value = false;
          AppSnackbar.error(message: data['msg'][0]);
        }
      } else {
        print("Error : ${response.statusCode}");
        isLoading.value = false;
        AppSnackbar.error(message: responseBody);
      }
    } catch (e) {
      print("Exception : $e");
      isLoading.value = false;
      AppSnackbar.error(message: e.toString());
    }
  }

  void togglePasswordVisibility(TextEditingController controller) {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
