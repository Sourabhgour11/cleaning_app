import 'package:cleaning_app/app/data/models/get_sub_sub_category_model.dart';
import 'package:cleaning_app/app/modules/user%20app/service_detail_screen/service_details_screen_controller.dart';
import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:cleaning_app/app/utils/app_button.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_style.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ServiceDetailsScreen extends StatelessWidget {
  ServiceDetailsScreen({Key? key}) : super(key: key);

  // Get the passed data via Get.arguments

  final ServiceDetailsScreenController controller = Get.put(ServiceDetailsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyle.appBarStyle("Service Details"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service image with favorite icon
            Obx(() => Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: controller.item.value.image != null
                        ? "${AppUrl.imageUrl}${controller.item.value.image}"
                        : "",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                    ),
                  ),
                ),
                // Favorite icon
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      final userId = AppLocalStorage.getUserId();
                      if (userId != null && controller.item.value.subCategoryId != null) {
                        controller.getLikeUnlikeApi(
                          userId: userId,
                          subCatId: controller.item.value.subCategoryId!,
                        );
                      }
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(
                        (controller.item.value.likeUnlikeStatus ?? 0) == 1
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: (controller.item.value.likeUnlikeStatus ?? 0) == 1
                            ? Colors.red
                            : Colors.grey,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            )),
            const SizedBox(height: 20),

            // Name
            Obx(() => Text(
              controller.item.value.name ?? "",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 10),

            // Price
            Obx(() => Text(
              "₹${controller.item.value.amount ?? 0}",
              style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.w600),
            )),
            const SizedBox(height: 10),

            // Description
            Obx(() => Text(
              controller.item.value.description ?? "No description available.",
              style: const TextStyle(fontSize: 16),
            )),
            const SizedBox(height: 20),

            // Additional Info
            Obx(() => Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.category, size: 20),
                    const SizedBox(width: 6),
                    Text("Category ID: ${controller.item.value.categoryId ?? 'N/A'}"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.subdirectory_arrow_right, size: 20),
                    const SizedBox(width: 6),
                    Text("Sub Category ID: ${controller.item.value.subCategoryId ?? 'N/A'}"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.confirmation_num, size: 20),
                    const SizedBox(width: 6),
                    Text("Cat Sub Cat ID: ${controller.item.value.subCategoryId ?? 'N/A'}"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 20),
                    const SizedBox(width: 6),
                    Text("Created at: ${controller.item.value.createtime ?? 'N/A'}"),
                  ],
                ),
                const SizedBox(height: 20),
                // Status indicator
                Row(
                  children: [
                    const Text(
                      "Status: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      controller.item.value.status == true ? "Active" : "Inactive",
                      style: TextStyle(
                          color: controller.item.value.status == true ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            )),

            const SizedBox(height: 30),
             AppButton(onPressed: (){
              Get.toNamed(AppRoutes.bookServiceStep1,arguments: controller.item.value.name);
            }, title: "Book Now")

          ],
        ),
      ),
    );
  }
}
