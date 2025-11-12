import 'dart:convert';

import 'package:cleaning_app/app/data/models/get_subcategory_by_categoryId_model.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:http/http.dart' as http;

class SubCategoriesScreenController extends GetxController {
  RxString appBarTitle = ''.obs;
  int? categoryId;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      // appBarTitle.value = Get.arguments.toString();
      appBarTitle.value = args['title'];
      categoryId = args['categoryId'];
    }
    getSubCatIdApi();
  }

  final Rx<GetSubCategoryByCategoryIdModel?> getSubCatModel = Rx<GetSubCategoryByCategoryIdModel?>(null);

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

  Future<void> getSubCatIdApi() async {
    isLoading.value = true;

    try {
      final token = AppLocalStorage.getToken();
      // Replace this with your actual API endpoint
      final url = Uri.parse(AppUrl.getSubCatByCatId(categoryId ?? 0));

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
          final GetSubCategoryByCategoryIdModel responseModel = GetSubCategoryByCategoryIdModel.fromJson(responseBody);
          getSubCatModel.value = responseModel;

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

  // Service popup data
  final RxBool isServicePopupVisible = false.obs;
  final RxInt selectedServiceIndex = 0.obs;
  final RxInt serviceQuantity = 1.obs;
  final RxBool isServiceFavorited = false.obs;

  // Show service popup
  void showServicePopup(int serviceIndex) {
    final services = getSubCatModel.value?.categoryArr ?? [];
    if (services.isEmpty || serviceIndex >= services.length) {
      return;
    }
    selectedServiceIndex.value = serviceIndex;
    isServicePopupVisible.value = true;
  }

  // Hide service popup
  void hideServicePopup() {
    isServicePopupVisible.value = false;
  }

  // Toggle service favorite
  void toggleServiceFavorite() {
    isServiceFavorited.value = !isServiceFavorited.value;
  }

  // Add service to cart
  void addServiceToCart(RxString appBarText) {
    // final totalPrice = service['discountedPrice'] * serviceQuantity.value;
    Get.toNamed(AppRoutes.bookServiceStep1, arguments: appBarText);
    hideServicePopup();
  }

  // Get current service details
  CategoryArr? get currentService {
    final services = getSubCatModel.value?.categoryArr ?? [];
    if (services.isEmpty) {
      return null;
    }
    if (selectedServiceIndex.value < services.length) {
      return services[selectedServiceIndex.value];
    }
    return services.first;
  }

  // Get formatted price
  String getFormattedPrice(num? price) {
    final value = price ?? 0;
    return 'AED ${value.toStringAsFixed(0)}';
  }

  // Get total price for current service
  double get totalServicePrice {
    final service = currentService;
    if (service == null) {
      return 0;
    }
    final amount = service.amount ?? 0;
    return amount * serviceQuantity.value;
  }
}
