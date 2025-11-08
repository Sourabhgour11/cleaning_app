import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/app/data/models/get_homepage_data_model.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:cleaning_app/app/utils/app_user_bottom_bar.dart';
import 'package:cleaning_app/app/utils/custom_shimmer_effect.dart';
import 'package:cleaning_app/app/utils/map_controller.dart';
import 'package:cleaning_app/app/utils/place_search_widget.dart';
import '../../../utils/app_greeting.dart';
import 'home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenController controller = Get.put(HomeScreenController());
  final CarouselSliderController carouselController =
  CarouselSliderController();

  final MapController mapController = Get.put(MapController());

  // Location selection popup

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // SliverAppBar with greeting, location, search
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 145,
                  floating: false,
                  pinned: true,
                  elevation: 2,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      // The current height of the SliverAppBar
                      double top = constraints.biggest.height;

                      // Detect if the appbar is collapsed
                      bool isCollapsed =
                          top < 120; // adjust threshold as needed

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          // Gradient Background
                          Container(
                            decoration: BoxDecoration(
                              gradient: AppColours.gradientColor,
                              // LinearGradient(
                              //   begin: Alignment.topLeft,
                              //   end: Alignment.bottomRight,
                              //   colors: [AppColours.appColor, AppColours.appColor2],
                              // ),
                              // color: AppColours.appColor
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                          ),

                          // Collapsible Content (fades out on scroll)
                          Positioned(
                            left: 16,
                            right: 16,
                            top: MediaQuery
                                .of(context)
                                .padding
                                .top + 20,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: isCollapsed ? 0.0 : 1.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                        () =>
                                        Text(
                                          "${AppGreeting()
                                              .getGreetingMessage()}, ${controller
                                              .userName.value}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: AppFonts.fontFamily,
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                  const SizedBox(height: 2),
                                  Obx(
                                        () =>
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 4),
                                            SizedBox(
                                              width: AppStyle.widthPercent(
                                                context,
                                                60,
                                              ),
                                              child: Text(
                                                controller.location.value,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: AppFonts
                                                      .fontFamily,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                // await _showLocationSelectionDialog();
                                              },
                                              child: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                  ),
                                  const SizedBox(height: 1),
                                ],
                              ),
                            ),
                          ),

                          // Search Bar pinned at the bottom
                          Positioned(
                            left: 16,
                            right: 16,
                            bottom: 16,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Icon(Icons.search, color: Colors.grey[600]),
                                  const SizedBox(width: 8),
                                  const Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search for "Home Cleaning"',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // Carousel Slider
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Obx(() =>
                              CarouselSlider.builder(
                                carouselController: carouselController,
                                itemCount: controller.homeDetailsModel.value
                                    ?.data?.first.bannerArr?.length ?? 0,
                                itemBuilder: (context, index, realIndex) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.03,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: AppUrl.imageUrl +
                                            (controller.homeDetailsModel.value
                                                ?.data?.firstOrNull
                                                ?.bannerArr?[index].image ??
                                                ''),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        placeholder: (context, url) =>
                                         CustomShimmer(
                                          width: double.infinity,
                                          height: AppStyle.widthPercent(context, 40),
                                          borderRadius: 10,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              color: Colors.grey[300],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                      ),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  height: AppStyle.widthPercent(context, 40),
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1.0,
                                  onPageChanged: (index, reason) {
                                    controller.currentIndex.value = index;
                                  },
                                ),
                              ),
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            // Check if data is still loading
                            if (controller.isLoading.value) {
                              // Show shimmer placeholders for indicators
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return const CustomShimmer(
                                    width: 8,
                                    height: 8,
                                    borderRadius: 4,
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                  );
                                }),
                              );
                            }

                            // Get the dynamic banner count from API data
                            final bannerCount = controller.homeDetailsModel.value?.data?.firstOrNull?.bannerArr?.length ?? 0;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(bannerCount, (index) {
                                return GestureDetector(
                                  onTap: () => carouselController.animateToPage(index),
                                  child: Container(
                                    width: controller.currentIndex.value == index ? 8 : 6,
                                    height: controller.currentIndex.value == index ? 8 : 6,
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: controller.currentIndex.value == index
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                    ),
                                  ),
                                );
                              }),
                            );
                          }),

                          const SizedBox(height: 20),
                          Obx(() {
                            final homeData = controller.homeDetailsModel.value;
                            final categoryList = homeData?.data?.isNotEmpty ==
                                true
                                ? homeData!.data!.first.categoryArr ?? []
                                : [];

                            if (controller.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (categoryList.isEmpty) {
                              return const Center(
                                child: Text(
                                  "No categories found",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }

                            return SizedBox(
                              height: 100, // enough height for icons + text
                              child: ListView.separated(
                                padding: const EdgeInsets.only(right: 13),
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryList.length,
                                separatorBuilder: (_, __) =>
                                const SizedBox(width: 16),
                                itemBuilder: (context, index) {
                                  final item = categoryList[index];

                                  return GestureDetector(
                                    onTap: () {
                                      controller.appBarTitle.value =
                                          item.name ?? "";
                                      Get.toNamed(
                                        AppRoutes.subCategory,
                                        arguments: controller.appBarTitle,
                                      );
                                    },
                                    child: SizedBox(
                                      width: 70,
                                      // slightly wider for better proportion
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          // Circular icon container
                                          Container(
                                            width: AppStyle.widthPercent(
                                                context, 14),
                                            height: AppStyle.widthPercent(
                                                context, 14),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: AppUrl.imageUrl +
                                                    (item.image ?? ''),
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Container(
                                                      color: Colors.grey[300],
                                                      child: const Center(
                                                        child: CircularProgressIndicator(
                                                            strokeWidth: 2),
                                                      ),
                                                    ),
                                                errorWidget: (context, url,
                                                    error) =>
                                                    Container(
                                                      color: Colors.grey[200],
                                                      child: const Icon(Icons
                                                          .image_not_supported,
                                                          color: Colors.grey),
                                                    ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 6),

                                          // Category name text
                                          Text(
                                            item.name ?? "",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: AppFonts.fontFamily,
                                              height: 1.2,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                          SizedBox(height: 10),
                          Text(
                            AppStrings.topPicksForYou,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23, fontFamily: AppFonts.fontFamily,
                            ),
                          ),

                          // SizedBox(height: AppStyle.heightPercent(context, 1)),
                          Obx(() {
                            return Column(
                              children: controller.homeDetailsModel.value?.data
                                  ?.first.subCategoryArr
                                  ?.map((category) {
                                final List<dynamic> subList = category.subcategories ?? [];
                                if (subList.isEmpty) return const SizedBox.shrink();
                                return simpleSalonGrid(
                                  category.categoryName ?? "Category",
                                  subList,
                                  controller,
                                  context,
                                );
                              }).toList() ??
                                  [],
                            );
                          }),


                          SizedBox(height: AppStyle.heightPercent(context, 14)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: AppUserBottomBar()),
          ],
        ),
      ),
    );
  }
}

// Simple version without colors
Widget simpleSalonGrid(
    String titleName,
    List<dynamic> itemList,
    HomeScreenController controller,
    BuildContext context,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
        child: Text(
          titleName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      Obx(() {
        // Use ternary operator instead of 'if' directly
        return controller.isLoading.value
            ? SizedBox(
          height: AppStyle.heightPercent(context, 13),
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // number of shimmer boxes
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return const CustomShimmer(
                width: 120,
                height: 100,
                borderRadius: 8,
                margin: EdgeInsets.symmetric(horizontal: 8),
              );
            },
          ),
        )
            : SizedBox(
          height: AppStyle.heightPercent(context, 12),
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 2,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final SubCategory item = itemList[index];
              final imageUrl = AppUrl.imageUrl + (item.image ?? '');
              final name = item.name ?? 'Unnamed';
              return InkWell(
                onTap: () {
                  controller.appBarTitle.value = name;
                  Get.toNamed(AppRoutes.subCategory, arguments: item);
                },
                child: Container(
                  width: AppStyle.widthPercent(context, 20),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    ],
  );
}



