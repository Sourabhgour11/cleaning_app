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
  var location = '1302, Nehru place, Jumeirah Beach Residence'.obs;
  var currentIndex = 0.obs;
  RxString appBarTitle = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getHomeDetailsApi();
  }

  var userName = "Ram".obs;

  var images = [AppImages.banner1, AppImages.banner2, AppImages.banner3];

  final List<Map<String, dynamic>> services = [
    {'name': 'General Cleaning', 'icon': AppImages.carService},
    {'name': 'Cleaning Subscription', 'icon': AppImages.cleaningSpray},
    {'name': 'Salon & Spa at Home', 'icon': AppImages.windowCleaning},
    {'name': 'Handyman & Maintenance', 'icon': AppImages.roomService},
    {'name': 'Healthcare at Home', 'icon': AppImages.products},
    {'name': 'AC Cleaning at Home', 'icon': AppImages.mop},
    {'name': 'Deep Cleaning', 'icon': AppImages.cleaningStaff},
  ];

  final List<Map<String, dynamic>> generalCleaning = [
    {'name': 'Home Cleaning', 'image': "lib/assets/images/home_cleaning.jpg"},
    {
      'name': 'Furniture Cleaning',
      'image': "lib/assets/images/furniture_cleaning.png",
    },
    {
      'name': 'Home Deep Cleaning',
      'image': "lib/assets/images/home_deep_cleaning.webp",
    },
    {
      'name': 'Kitchen & Bathroom Deep Cleaning',
      'image': "lib/assets/images/kitchen_bathroom_cleaning.webp",
    },
    {
      'name': 'Laundry & Deep Cleaning',
      'image': "lib/assets/images/laundry_drycleaning.png",
    },
    {'name': 'AC Cleaning', 'image': "lib/assets/images/ac_cleaning.webp"},
    {'name': 'Car Wash', 'image': "lib/assets/images/car_wash.webp"},
  ];

  final List<Map<String, dynamic>> salonAndSpa = [
    {'name': "Women's Salon", 'image': "lib/assets/images/woman_salon.webp"},
    {'name': "Women's Spa", 'image': "lib/assets/images/woman's_spa.jpg"},
    {'name': "Men's Salon", 'image': "lib/assets/images/mans_salon.jpg"},
    {'name': "Men's Spa", 'image': "lib/assets/images/mans_spa.jpg"},
    {
      'name': 'Nail Extensions',
      'image': "lib/assets/images/nail_extension.jpg",
    },
    {'name': 'Lashes & Brows', 'image': "lib/assets/images/lashes_brows.webp"},
    {'name': 'Spray Tanning', 'image': "lib/assets/images/spray_tanning.jpg"},
    {'name': 'Makeup', 'image': "lib/assets/images/makeup.jpg"},
  ];

  final List<Map<String, dynamic>> handyMan = [
    {
      'name': "Handyman & Maintenance",
      'image': "lib/assets/images/handyman.jpg",
    },
    {'name': "Home Painting", 'image': "lib/assets/images/home_painting.jpeg"},
    {
      'name': "Water Tank Cleaning",
      'image': "lib/assets/images/water_tank_cleaning.jpg",
    },
  ];

  final List<Map<String, dynamic>> healthCareAtHome = [
    {
      'name': "Lab Tests at Home",
      'image': "lib/assets/images/lab_test_at_home.jpg",
    },
    {
      'name': "IV Therapy at Home",
      'image': "lib/assets/images/iv_therapy_at_home.jpeg",
    },
    {
      'name': "Doctor Consultations",
      'image': "lib/assets/images/doctor_consultations.jpg",
    },
    {
      'name': "Flu Vaccine at Home",
      'image': "lib/assets/images/flu_vaccine.jpeg",
    },
    {
      'name': 'Nurse Care at Home',
      'image': "lib/assets/images/nurse_care_at_home.jpg",
    },
    {
      'name': 'Psychotherapy at Home',
      'image': "lib/assets/images/physiotherary_at_home.jpg",
    },
  ];

  final List<Map<String, dynamic>> fitness = [
    {'name': "Personal Trainer", 'image': "lib/assets/images/fitness_img.jpg"},
    {'name': "Yoga", 'image': "lib/assets/images/fitness2_img.jpg"},
  ];

  final List<Map<String, dynamic>> petCare = [
    {'name': "Pet Grooming", 'image': "lib/assets/images/pet_care_img.png"},
    {'name': "Vet at Home", 'image': "lib/assets/images/pet_care2_img.jpg"},
    {'name': "Vet at Home", 'image': "lib/assets/images/pet_care3_img.webp"},
  ];

  // Method to update location
  void updateLocation(String newLocation) {
    location.value = newLocation;
  }

  final Rx<GetHomeScreenDataModel?> homeDetailsModel = Rx<GetHomeScreenDataModel?>(null);




  var bannerArreyModel = <BannerArr>[].obs; // ✅ RxList<BannerArr>

  final dio = Dio(
    BaseOptions(
      baseUrl: AppUrl.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );


  Future<void> getHomeDetailsApi() async {
    isLoading.value = true;

    try {
      final userId = AppLocalStorage.getUserId();
      final token = AppLocalStorage.getToken();
      // Replace this with your actual API endpoint
      final url = Uri.parse('${AppUrl.baseUrl}/get_home_page_api?user_id=$userId');

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
