import 'dart:convert';
import 'dart:ui';

import 'package:cleaning_app/app/data/models/get_homepage_data_model.dart';
import 'package:cleaning_app/app/utils/app_constants.dart';
import 'package:cleaning_app/app/utils/app_images.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeScreenController extends GetxController {
  dynamic userDetails;
  var location ;
  var currentIndex = 0.obs;
  RxString appBarTitle = "".obs;
  RxBool isLoading = false.obs;


  var categoryId;

  @override
  void onInit() {
    super.onInit();
    getHomeDetailsApi();
    location = AppLocalStorage.getUserDetails();

  }

  var userName = "Ram".obs;

  // Method to update location
  void updateLocation(String newLocation) {
    location.value = newLocation;
  }

  final Rx<GetHomeScreenDataModel?> homeDetailsModel = Rx<GetHomeScreenDataModel?>(null);

  var bannerArrayModel = <BannerArr>[].obs; // ✅ RxList<BannerArr>

  Future<void> getHomeDetailsApi() async {
    isLoading.value = true;

    try {
      final userId = AppLocalStorage.getUserId();
      final token = AppLocalStorage.getToken();
      // Replace this with your actual API endpoint
      final url = Uri.parse(AppUrl.homeDetailsApi(userId ?? ""));

      // Optional headers (e.g., if you have token authentication)
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
         'Authorization': 'Bearer ${token}', // if needed
      };

      final response = await http.get(url, headers: headers);

      print("📡 Home API URL: $url");
      print("📩 Status Code: ${response.statusCode}");
      print("📨 Response: ${response.body}");
      final data = json.decode(response.body);
      print("data data is here :${data}");
      if (response.statusCode == 200) {
        if (data['status'] == true || data['success'] == true) {

          final responseBody = jsonDecode(response.body);
          final GetHomeScreenDataModel responseModel = GetHomeScreenDataModel.fromJson(responseBody);

          homeDetailsModel.value = responseModel;

          print("message is here${data['data']}");


        } else {
          Get.snackbar('Error', 'Failed to fetch home details: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
