import 'dart:convert';

import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:http/http.dart' as http;

class UserBookingScreenController extends GetxController{

  var upcomingBookings = <Map<String, String>>[].obs;
  var pastBookings = <Map<String, String>>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Example data
    upcomingBookings.addAll([
      {
        'service': 'Home Cleaning',
        'date': '12 Oct 2025',
        'time': '10:00 AM',
      },
      {
        'service': 'AC Repair',
        'date': '15 Oct 2025',
        'time': '02:00 PM',
      },
    ]);

    pastBookings.addAll([
      {
        'service': 'Bathroom Cleaning',
        'date': '01 Oct 2025',
        'time': '11:00 AM',
      },
    ]);
  }


  Future<void> getUserBookingsApi() async {
    isLoading.value = true;

    try {
      final userId = AppLocalStorage.getUserId();
      final token = AppLocalStorage.getToken();
      // Replace this with your actual API endpoint
      final url = Uri.parse(AppUrl.getUserBookingApi(userId ?? ""));

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
          // final GetHomeScreenDataModel responseModel = GetHomeScreenDataModel.fromJson(responseBody);
          //
          // homeDetailsModel.value = responseModel;

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