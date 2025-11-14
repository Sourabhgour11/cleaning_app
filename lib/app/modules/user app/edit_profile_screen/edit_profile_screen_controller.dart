import 'dart:convert';
import 'dart:io';
import 'package:cleaning_app/app/modules/user%20app/profile_screen/profile_screen_controller.dart';
import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:cleaning_app/app/utils/app_camera_popup.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_constants.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:cleaning_app/app/utils/map_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../utils/app_images.dart';
import '../../../utils/app_snackbar.dart';

class EditProfileScreenController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  // Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final MapController mapController = Get.put(MapController());

  RxString userImageUrl = ''.obs; // API image URL

  final Rx<File?> pickedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  /// Open the popup and get image
  Future<void> pickImage(BuildContext context) async {
    try {
      final File? imageFile = await context.showImageSourceDialog();
      if (imageFile != null) {
        pickedImage.value = imageFile;

        Get.snackbar(
          "Image Selected ✅",
          "Image loaded successfully.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColours.appColor.withOpacity(0.8),
          colorText: AppColours.white,
        );
      } else {
        Get.snackbar(
          "Cancelled",
          "No image was selected.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey.shade600,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong while picking the image: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  /// EDIT PROFILE API
  Future<void> editProfileApi({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    try {
      isLoading.value = true;

      final uri = Uri.parse(AppUrl.editProfile);
      var request = http.MultipartRequest('POST', uri);

      final userId = AppLocalStorage.getUserId();
      final token = AppLocalStorage.getToken(); // ✅ your saved token

      // ✅ Add headers with Bearer token
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Accept'] = 'application/json';
      }

      final selectedPlace = mapController.selectedPlace.value;

      final latitude = selectedPlace?.lat != null
          ? selectedPlace!.lat.toStringAsFixed(6)
          : AppConstants.latitude.toString();

      final longitude = selectedPlace?.lng != null
          ? selectedPlace!.lng.toStringAsFixed(6)
          : AppConstants.longitude.toString();

      // ✅ Add form fields
      request.fields.addAll({
        'user_id': userId ?? "",
        'name': name,
        'email': emailController.text,
        'phone_code': '+${AppConstants.phoneCode ?? 91}',
        'mobile': phoneController.text,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
      });

      // ✅ Add image (if selected)
      if (pickedImage.value != null) {
        final file = pickedImage.value!;
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            file.path,
            // filename: file.path.split('/').last,
          ),
        );
      }

      // ✅ Send request
      final response = await request.send();

      // ✅ Handle response
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        var data =jsonDecode(responseBody);
        if(data['success']=="true" || data['success']==true){
          // Extract and save user data
          String? userId;
          var token;
          Map<String, dynamic>? userDetails;

          if (data['userDataArray'] != null||data['userDataArray'].isNotEmpty) {
            print("Data : ${data['userDataArray']}");

            userDetails = data['userDataArray'];

            if (userDetails != null) {
              userId = userDetails['user_id']?.toString() ?? '';
            }

          }
          token = AppLocalStorage.getToken();
          // Save user data to local storage
          if (userId != null) {
            bool saved = await AppLocalStorage.saveUserData(
              userId: userId,
              token: token,
              userDetails: userDetails,
            );
            await AppConstants.loadUserDetails();

            if (saved) {
              print("User data saved to local storage");
              Get.offAllNamed(AppRoutes.userBottomNav);

            }
          }

          print("✅ Profile updated successfully: $responseBody : Message : ${ data['msg'][0].toString()}");

          print("Message : ${ data['msg'][0].toString()}");

          AppSnackbar.success(message: data['msg'][0].toString());



        }
        else{

        }
      } else {
        print("❌ Error ${response.statusCode}: $responseBody");
      }
    } catch (e) {
      print("⚠️ Exception while updating profile: $e");
    } finally {
      isLoading.value = false;
    }
  }


  void loadProfileData() {
    // Load existing profile data
    nameController.text = AppConstants.userName.toString();
    emailController.text = AppConstants.userEmail.toString();
    phoneController.text = AppConstants.userMobile.toString();
    addressController.text =AppConstants.address.toString() ;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void updateProfile() {
    print("is update call");
    // if (validateForm()) {
    //   isLoading.value = true;
    //   // Simulate API call
    //   Future.delayed(const Duration(seconds: 2), () {
    //     isLoading.value = false;
    //     Get.snackbar(
    //       'Success',
    //       'Profile updated successfully!',
    //       snackPosition: SnackPosition.TOP,
    //       backgroundColor: Colors.green,
    //       colorText: Colors.white,
    //     );
    //
    //     Get.back();
    //   });
    // }


  }

  bool validateForm() {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your name',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      Get.snackbar('Error', 'Please enter a valid email',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your phone number',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    if (addressController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your address',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    // Password fields are optional for profile update
    if (passwordController.text.isNotEmpty) {
      if (passwordController.text.length < 6) {
        Get.snackbar('Error', 'Password must be at least 6 characters',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return false;
      }
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar('Error', 'Passwords do not match',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return false;
      }
    }
    return true;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}