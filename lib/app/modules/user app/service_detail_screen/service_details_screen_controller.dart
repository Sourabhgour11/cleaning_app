import 'dart:convert';
import 'package:cleaning_app/app/data/models/get_sub_sub_category_model.dart';
import 'package:cleaning_app/app/modules/user%20app/sub_subCategory_screen/sub_subCategory_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:http/http.dart' as http;

class ServiceDetailsScreenController extends GetxController {

  final Rx<CategoryArray> item = CategoryArray().obs;

  @override
  void onInit() {
    super.onInit();
    // Get the passed argument (the CategoryArr instance)
    item.value = Get.arguments;
    print("${item.value.name}");
  }

  @override
  void onClose() {
    // Update the parent screen's list when closing
    _updateParentScreen();
    super.onClose();
  }

  void _updateParentScreen() {
    try {
      // Find and update SubSubCategoryController if it exists
      if (Get.isRegistered<SubSubCategoryController>()) {
        final subSubCategoryController = Get.find<SubSubCategoryController>();
        final currentData = subSubCategoryController.subSubCategoryData.value;
        if (currentData != null && currentData.categoryArray != null) {
          final categoryArr = List<CategoryArray>.from(currentData.categoryArray!);
          final itemIndex = categoryArr.indexWhere(
            (catItem) => catItem.subCategoryId == item.value.subCategoryId,
          );
          if (itemIndex != -1) {
            // Update the item in the list with the current status
            categoryArr[itemIndex].likeUnlikeStatus = item.value.likeUnlikeStatus;
            // Create a new model instance to trigger GetX reactivity
            subSubCategoryController.subSubCategoryData.value = GetSubSubCategoryModel(
              success: currentData.success,
              msg: currentData.msg,
              categoryArray: categoryArr,
            );
          }
        }
      }
    } catch (e) {
      print("Error updating parent screen: $e");
    }
  }

  Future<void> getLikeUnlikeApi({required String userId, required int subCatId}) async {
    try {
      print("Ids : $userId : $subCatId");
      final token = AppLocalStorage.getToken();
      final url = Uri.parse(AppUrl.likeUnlike);

      // Request headers
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Request body
      final body = jsonEncode({
        'user_id': userId,
        'sub_category_id': subCatId,
      });

      // POST request
      final response = await http.post(url, headers: headers, body: body);

      print("📡 POST API URL: $url");
      print("📩 Status Code: ${response.statusCode}");
      print("📨 Response Body: ${response.body}");

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['status'] == true || data['success'] == true) {
          // Update the item's like status
          final currentItem = item.value;
          final currentStatus = currentItem.likeUnlikeStatus ?? 0;
          final newStatus = currentStatus == 1 ? 0 : 1;
          // Create a new instance with updated status to trigger GetX reactivity
          item.value = CategoryArray(
            subCategoryId: currentItem.subCategoryId,
            catSubCatId: currentItem.catSubCatId,
            categoryId: currentItem.categoryId,
            name: currentItem.name,
            image: currentItem.image,
            amount: currentItem.amount,
            description: currentItem.description,
            status: currentItem.status,
            likeUnlikeStatus: newStatus,
            likeUnlikeStatusLabel: currentItem.likeUnlikeStatusLabel,
            createtime: currentItem.createtime,
          );
          print("✅ Like/Unlike successful: Updated status to ${item.value.likeUnlikeStatus}");
          
          // Also update the parent screen's list immediately
          _updateParentScreen();
        } else {
          Get.snackbar('Error', data['message'] ?? 'Failed to like/unlike item');
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Exception: $e");
      Get.snackbar('Error', 'Exception: $e');
    }
  }

}