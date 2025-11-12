import 'dart:convert';
import 'dart:io';

import 'package:cleaning_app/app/utils/app_camera_popup.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_constants.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_snackbar.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:cleaning_app/app/utils/map_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../utils/app_images.dart';

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

  // Profile Image
  var profileImage = AppImages.profileImage.obs;

  final Rx<File?> selectedImage = Rx<File?>(null);

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
        selectedImage.value = imageFile;

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

      final uri = Uri.parse(AppUrl.editProfile); // define this in AppUrl
      var request = http.MultipartRequest('POST', uri);

      var userId = AppLocalStorage.getUserId();

      // Add fields
      request.fields.addAll({
        'user_id': userId ?? "", // or fetch from storage
        'name': name,
        'email': email,
        'phone_code': '+91', // or your stored code
        'mobile': phone,
        'address': address,
        'latitude': mapController.selectedPlace.value?.lat.toString() ?? '',
        'longitude': mapController.selectedPlace.value?.lng.toString() ?? '',
        'device_type': AppConstants.deviceType,
        'player_id': AppConstants.playerId,
      });

      // Add image file (if selected)
      if (selectedImage.value != null) {
        final file = selectedImage.value!;
        request.files.add(
          await http.MultipartFile.fromPath('image', file.path),
        );
      }

      // Send the request
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['success'] == true || data['status'] == 'yes') {
          AppSnackbar.success(
            message: data['msg'][0]?.toString() ?? 'Profile updated successfully',
          );
          Get.back(result: true);
        } else {
          AppSnackbar.error(
            message: (data['msg'] is List ? data['msg'][0] : data['msg']).toString(),
          );
        }
      } else {
        AppSnackbar.error(
          message: 'Failed: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      AppSnackbar.error(message: 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadProfileData() {
    // Load existing profile data
    nameController.text = 'John Smith';
    emailController.text = 'john.smith@email.com';
    phoneController.text = '+91 98765 43210';
    addressController.text = '123 Main Street, Downtown, City';
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void updateProfile() {
    if (validateForm()) {
      isLoading.value = true;
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          'Profile updated successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back();
      });
    }
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