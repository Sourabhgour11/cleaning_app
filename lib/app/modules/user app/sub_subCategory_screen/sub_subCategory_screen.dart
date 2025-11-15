import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/app/modules/user%20app/sub_subCategory_screen/sub_subCategory_screen_controller.dart';
import 'package:cleaning_app/app/rotes/app_routes.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_style.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubSubCategoryScreen extends StatelessWidget {
  SubSubCategoryScreen({super.key});

  final SubSubCategoryController controller = Get.put(
    SubSubCategoryController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppStyle.appBarStyle("${controller.appBarName.value}"),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColours.appColor),
          );
        }

        final categoryArr =
            controller.subSubCategoryData.value?.categoryArray ?? [];

        if (categoryArr.isEmpty) {
          return const Center(
            child: Text(
              "No services available",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 4.5 / 5,
          ),
          itemCount: controller.subSubCategoryData.value?.categoryArray?.length,
          itemBuilder: (context, index) {
            final item =
                controller.subSubCategoryData.value?.categoryArray?[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.serviceDetailsScreen, arguments: item);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 1,
                child: Container(
                  width: 150, // reduce card width (optional)
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // IMAGE + HEART
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: "${AppUrl.imageUrl}${item?.image}",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 110, // 🔥 reduced height
                              placeholder: (context, url) => Container(
                                height: 110,
                                color: Colors.grey[200],
                                child: const Center(
                                  child: CircularProgressIndicator(strokeWidth: 1.5),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 110,
                                color: Colors.grey[200],
                                child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                              ),
                            ),
                          ),

                          // ❤️ FAVORITE ICON
                          Positioned(
                            top: 6,
                            right: 6,
                            child: GestureDetector(
                              onTap: () {
                                final userId = AppLocalStorage.getUserId();
                                if (userId != null && item?.subCategoryId != null) {
                                  controller.getLikeUnlikeApi(
                                    userId: userId,
                                    subCatId: item!.subCategoryId!,
                                  );
                                }
                              },
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  (item?.likeUnlikeStatus ?? 0) == 1
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: (item?.likeUnlikeStatus ?? 0) == 1
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // TEXT SECTION
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // NAME
                            Text(
                              item?.name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14, // 🔥 smaller font
                              ),
                            ),

                            const SizedBox(height: 3),

                            // DESCRIPTION
                            Text(
                              item?.description ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),

                            const SizedBox(height: 5),

                            // PRICE
                            Text(
                              controller.getFormattedPrice(item?.amount ?? 0),
                              style: const TextStyle(
                                color: AppColours.appColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13, // 🔥 smaller font
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),



            );
          },
        );
      }),
    );
  }

  void _showServiceBottomSheet(BuildContext context, dynamic service) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: service.image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              service.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              service.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontFamily: AppFonts.fontFamily,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              controller.getFormattedPrice(service.price),
              style: const TextStyle(
                color: AppColours.appColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: AppStyle.widthPercent(context, 80),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColours.appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () => Get.snackbar(
                  "Added",
                  "${service.name} added to your cart",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green[50],
                  colorText: Colors.black,
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
