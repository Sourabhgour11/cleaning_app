import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeScreenController controller = Get.put(HomeScreenController());
  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // SliverAppBar with greeting, location, search
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColours.appColor.withOpacity(0.4),
              expandedHeight: 150,
              floating: false,
              pinned: true,
              elevation: 2,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  var top = constraints.biggest.height;
                  bool isCollapsed = top <= kToolbarHeight + 60;

                  return FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: isCollapsed ? 0.0 : 1.0,
                              child: Text(
                                "😊 Good afternoon, ${controller.userName.value}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.fontFamily,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.blueAccent,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    controller.location.value,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontFamily: AppFonts.fontFamily,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.keyboard_arrow_down, size: 18),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Search Bar
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 8),
                                const Icon(Icons.search, color: Colors.grey),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Search for "Home Cleaning"',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Promo Section
                          // Obx(
                          //       () => AnimatedOpacity(
                          //     duration: const Duration(milliseconds: 300),
                          //     opacity: isCollapsed ? 0.0 : 1.0,
                          //     child: Container(
                          //       width: double.infinity,
                          //       decoration: BoxDecoration(
                          //         color: Colors.blue[50],
                          //         borderRadius: BorderRadius.circular(12),
                          //       ),
                          //       padding: const EdgeInsets.all(10),
                          //       child: const Column(
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           Text(
                          //             "Secret's out.",
                          //             style: TextStyle(
                          //               fontWeight: FontWeight.bold,
                          //               fontSize: 18,
                          //               fontFamily: AppFonts.fontFamily,
                          //             ),
                          //           ),
                          //           SizedBox(height: 4),
                          //           Text(
                          //             "10 years & 10M+ bookings later.",
                          //             style: TextStyle(
                          //               color: Colors.black87,
                          //               fontFamily: AppFonts.fontFamily,
                          //             ),
                          //           ),
                          //           SizedBox(height: 4),
                          //           Text(
                          //             "Here's the Justlife Promise",
                          //             style: TextStyle(
                          //               color: Colors.blueAccent,
                          //               decoration: TextDecoration.underline,
                          //               fontFamily: AppFonts.fontFamily,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Carousel Slider
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: controller.images.length,
                      itemBuilder: (context, index, realIndex) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            controller.images[index],
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 180,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        onPageChanged: (index, reason) {
                          controller.currentIndex.value = index;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.images.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () =>
                                carouselController.animateToPage(entry.key),
                            child: Container(
                              width: controller.currentIndex.value == entry.key
                                  ? 12
                                  : 8,
                              height: controller.currentIndex.value == entry.key
                                  ? 12
                                  : 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.currentIndex.value == entry.key
                                    ? Colors.blueAccent
                                    : Colors.grey,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // GridView for services
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = controller.services[index];
                  return Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          item.icon,
                          color: AppColours.appColor,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: AppFonts.fontFamily,
                        ),
                        textAlign: TextAlign.center,
                      ),
                     
                    ],
                  );
                }, childCount: controller.services.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }
}
