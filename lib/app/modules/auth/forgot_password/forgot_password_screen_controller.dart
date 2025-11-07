import 'dart:convert';

import 'package:http/http.dart' as http show MultipartRequest;

import '../../../utils/app_export.dart';
import '../../../utils/app_local_storage.dart';
import '../../../utils/app_snackbar.dart';
import '../../../utils/app_url.dart';

class ForgotPasswordScreenController extends GetxController {
  var isLoading = false.obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  final FocusNode emailFocusNode = FocusNode();

  Future<void> sendResetEmail(email) async {
    print("object :- $email");
    isLoading.value = true;
    if (email.isEmpty) {
      print("Email And Password Is Not Empty");
      AppSnackbar.error(
        message: AppStrings.enterEmailToReceiveResetInstructions,
      );
      isLoading.value = false;
    } else {
      await forgotApi(email);
    }
  }

  Future<void> forgotApi(email) async {
    print("ForGot Password Api Calling...");
    try {
      // Create FormData
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppUrl.forgotPassword),
      );
      request.fields.addAll({'email': email});

      var response = await request.send();
      print("Body : $response");

      // Read response body from StreamedResponse
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(responseBody);
        print("Data: $data");
        if (data['success'] == true) {
          isLoading.value = false;
          String? userId;
          Map<String, dynamic>? userDetails;
          if (data['userDataArray'] != null) {
            print("Data : ${data['userDataArray']}");
            if (data['userDataArray'].isNotEmpty) {
              isLoading.value = false;
              AppSnackbar.success(message: data['msg'][0].toString());
              Get.toNamed(AppRoutes.forgotOtp);
              userDetails = data['userDataArray'];
              if (userDetails != null) {
                userId = userDetails['user_id']?.toString() ?? '';
              }
            }
            // Save user data to local storage
            if (userId != null) {
              print("User Id : $userId");
              bool saved = await AppLocalStorage.saveUserData(
                userId: userId,
                token: '',
                userDetails: userDetails,
              );
              print("User Details Saved Successfully : $saved");
              if (saved) {
                print("User data saved to local storage");
              }
            }
          } else {
            isLoading.value = false;
            AppSnackbar.error(message: data['msg'][0].toString());
          }
        } else {
          isLoading.value = false;
          AppSnackbar.error(message: data['msg'][0].toString());
        }
      }
    } catch (e) {
      isLoading.value = false;
      print("Exception : $e");
      AppSnackbar.error(message: e.toString());
    }
  }
}
