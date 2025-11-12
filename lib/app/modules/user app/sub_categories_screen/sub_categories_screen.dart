import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:cleaning_app/app/utils/app_url.dart';

import 'sub_categories_screen_controller.dart';

class SubCategoriesScreen extends StatelessWidget {
  SubCategoriesScreen({super.key});

  final SubCategoriesScreenController controller = Get.put(
    SubCategoriesScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyle.appBarStyle(controller.appBarTitle.value),
      body: GestureDetector(
        onTap: () {
          controller.hideServicePopup();
        },
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(() {
                      // ✅ 1. Show loading indicator when data is being fetched
                      if (controller.isLoading.value) {
                        return SizedBox(
                          height: AppStyle.heightPercent(context, 80), // optional placeholder space
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColours.appColor, // use color (not backgroundColor)
                            ),
                          ),
                        );
                      }

                      // ✅ 2. Extract category array safely
                      final categoryArr =
                          controller.getSubCatModel.value?.categoryArr ?? [];

                      // ✅ 3. Show "no data" state when empty
                      if (categoryArr.isEmpty) {
                        return const SizedBox(
                          height: 400,
                          child: Center(
                            child: Text(
                              "No subcategories found",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontFamily: AppFonts.fontFamily,
                              ),
                            ),
                          ),
                        );
                      }

                      // ✅ 4. Finally show the grid when loaded and not empty
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 3 / 2,
                        ),
                        itemCount: categoryArr.length,
                        itemBuilder: (context, index) {
                          final item = categoryArr[index];

                          return GestureDetector(
                            onTap: () => controller.showServicePopup(index),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Stack(
                                children: [
                                  // Cached network image
                                  CachedNetworkImage(
                                    imageUrl:
                                    AppUrl.imageUrl + (item.image ?? ""),
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                    errorWidget:
                                        (context, url, error) => const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
                                  ),

                                  // Dark overlay
                                  Container(
                                      color: Colors.black.withOpacity(0.4)),

                                  // Text label
                                  Positioned(
                                    bottom: 6,
                                    left: 6,
                                    right: 6,
                                    child: Text(
                                      item.name ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.fontFamily,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => controller.isServicePopupVisible.value
                  ? Positioned.fill(child: _buildServicePopup(controller))
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicePopup(SubCategoriesScreenController controller) {
    return Container(
      color: Colors.black.withOpacity(0.5), // semi-transparent background
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Obx(() => _buildServiceContent(controller, context)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceContent(
      SubCategoriesScreenController controller,
      BuildContext context,
      ) {
    final service = controller.currentService;

    if (service == null) return const SizedBox.shrink();

    final imageUrl = (service.image ?? '').isNotEmpty
        ? AppUrl.imageUrl + (service.image ?? '')
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Handle bar
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            width: 50,
            // height: 5,
            decoration: BoxDecoration(
              color: Colors.red[300],
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
        ),

        // Customize label
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            AppStrings.customize.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.red[600],
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Service title & description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.name ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              const SizedBox(height: 8),
              if ((service.description ?? '').isNotEmpty)
                Text(
                  service.description ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Service image
        if (imageUrl != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      height: 180,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 180,
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: controller.toggleServiceFavorite,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          controller.isServiceFavorited.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.isServiceFavorited.value
                              ? Colors.red
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 20),

        // Service price & date
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.getFormattedPrice(service.amount),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              if ((service.createtime ?? '').isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  service.createtime ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Add button
        Center(
          child: SizedBox(
            height: AppStyle.heightPercent(context, 5),
            width: AppStyle.widthPercent(context, 80),
            child: AppButton(
              onPressed: () {
                controller.addServiceToCart(controller.appBarTitle);
              },
              title:
              "${AppStrings.addFor} ${controller.getFormattedPrice(controller.totalServicePrice)}",
            ),
          ),
        ),

        // const SizedBox(height: 30),
      ],
    );
  }

}
