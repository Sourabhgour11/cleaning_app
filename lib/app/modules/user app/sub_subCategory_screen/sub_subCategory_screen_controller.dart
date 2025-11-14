import 'dart:convert';
import 'package:cleaning_app/app/data/models/get_sub_sub_category_model.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SubSubCategoryController extends GetxController {
  RxBool isLoading = true.obs;

  final Rx<GetSubSubCategoryModel?> subSubCategoryData = Rx<GetSubSubCategoryModel?>(null);
  var categoryId = 0.obs;
  var subCategoryId = 0.obs;
  var appBarName = "".obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    categoryId.value = args?['catId'] ?? 0;
    subCategoryId.value = args?['subCatId'] ?? 0;
     appBarName.value = args?['name'] ?? "";
    print("Category ID: ${categoryId.value}, SubCategory ID: ${subCategoryId.value}");
    getSubSubCategoryApi();
  }

  Future<void> getSubSubCategoryApi() async {
    isLoading.value = true;

    try {
      final token = AppLocalStorage.getToken();
      // Replace this with your actual API endpoint
      final url = Uri.parse(AppUrl.getSubSubCategoryApi(subCategoryId.value , categoryId.value));

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
          final GetSubSubCategoryModel responseModel = GetSubSubCategoryModel.fromJson(responseBody);

          subSubCategoryData.value = responseModel;

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

  String getFormattedPrice(num price) => "₹${price.toStringAsFixed(0)}";
}