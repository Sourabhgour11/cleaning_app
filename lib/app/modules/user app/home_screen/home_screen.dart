import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cleaning_app/app/utils/app_user_bottom_bar.dart';
import '../../../utils/app_greeting.dart';
import '../../../utils/app_location_popup.dart';
import 'home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenController controller = Get.put(HomeScreenController());
  final CarouselSliderController carouselController =
      CarouselSliderController();

  // Location selection popup
  Future<void> _showLocationSelectionDialog() async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Select Your Location',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Description
                const Text(
                  'Choose how you\'d like to set your location',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Current Location Button
                _buildLocationOption(
                  context: context,
                  icon: Icons.my_location,
                  title: 'Use Current Location',
                  subtitle: 'Get your location automatically',
                  color: Colors.green,
                  onTap: () async {
                    Navigator.of(context).pop(); // Close dialog first
                    await _getCurrentLocation(context);
                  },
                ),

                const SizedBox(height: 16),

                // Manual Entry Button
                _buildLocationOption(
                  context: context,
                  icon: Icons.edit_location,
                  title: 'Enter Manually',
                  subtitle: 'Type your city or address',
                  color: Colors.blue,
                  onTap: () async {
                    Navigator.of(context).pop(); // Close dialog first
                    await _showManualLocationDialog(context);
                  },
                ),

                const SizedBox(height: 20),

                // Cancel Button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.05),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final locationPopup = AppLocationPopup();
      final location = await locationPopup.getCurrentLocation();

      // Close loading dialog
      Navigator.of(context).pop();

      if (location.isNotEmpty && location != "Unknown Location") {
        // Show success and return location
        Get.snackbar(
          'Location Found',
          'Your location: $location',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // Update the home screen location
        controller.updateLocation(location);
      } else {
        // Show error and fallback to manual entry
        Get.snackbar(
          'Location Error',
          'Could not get current location. Please try manual entry.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );

        // Show manual entry dialog as fallback
        await _showManualLocationDialog(context);
      }
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();

      Get.snackbar(
        'Error',
        'Failed to get location: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _showManualLocationDialog(BuildContext context) async {
    final TextEditingController locationController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(Icons.edit_location, color: Colors.blue),
              const SizedBox(width: 10),
              const Text('Enter Location'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please enter your city or address',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'e.g., New York, NY',
                  prefixIcon: const Icon(Icons.location_city),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
                autofocus: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final location = locationController.text.trim();
                if (location.isNotEmpty) {
                  Navigator.of(context).pop();
                  Get.snackbar(
                    'Location Set',
                    'Your location: $location',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );

                  // Update the home screen location
                  controller.updateLocation(location);
                } else {
                  Get.snackbar(
                    'Error',
                    'Please enter a valid location',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Set Location'),
            ),
          ],
        );
      },
    );
  }

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
                            top: MediaQuery.of(context).padding.top + 20,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: isCollapsed ? 0.0 : 1.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Text(
                                      "${AppGreeting().getGreetingMessage()}, ${controller.userName.value}",
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
                                    () => Row(
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
                                              fontFamily: AppFonts.fontFamily,
                                              overflow: TextOverflow.ellipsis,
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
                        left: MediaQuery.of(context).size.width * 0.03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          CarouselSlider.builder(
                            carouselController: carouselController,
                            itemCount: controller.images.length,
                            itemBuilder: (context, index, realIndex) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    controller.images[index],
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 170,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                controller.currentIndex.value = index;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: controller.images.asMap().entries.map((
                                entry,
                              ) {
                                return GestureDetector(
                                  onTap: () => carouselController.animateToPage(
                                    entry.key,
                                  ),
                                  child: Container(
                                    width:
                                        controller.currentIndex.value ==
                                            entry.key
                                        ? 8
                                        : 6,
                                    height:
                                        controller.currentIndex.value ==
                                            entry.key
                                        ? 8
                                        : 6,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          controller.currentIndex.value ==
                                              entry.key
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 100, // enough height for icons + text
                            child: ListView.separated(
                              padding: const EdgeInsets.only(right: 13),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.services.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 16),
                              itemBuilder: (context, index) {
                                final item = controller.services[index];
                                return GestureDetector(
                                  onTap: () {
                                    controller.appBarTitle.value = item['name'];
                                    Get.toNamed(
                                      AppRoutes.subCategory,
                                      arguments: controller.appBarTitle,
                                    );
                                  },
                                  child: SizedBox(
                                    width: 60,
                                    // fix width for all items (keeps alignment)
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: AppColours.appColor
                                                .withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: Image.asset(
                                            item['icon'],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        // const SizedBox(height: 6),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              item['name'],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppFonts.fontFamily,
                                                wordSpacing: 0.5,
                                                letterSpacing: 0.1,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            AppStrings.topPicksForYou,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 1)),
                          simpleSalonGrid(
                            "General Cleaning",
                            controller,
                            context,
                            controller.generalCleaning,
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),
                          simpleSalonGrid(
                            "Salon & Spa at Home",
                            controller,
                            context,
                            controller.salonAndSpa,
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),
                          simpleSalonGrid(
                            "Handyman & Maintainence",
                            controller,
                            context,
                            controller.handyMan,
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),
                          simpleSalonGrid(
                            "Healthcare at Home",
                            controller,
                            context,
                            controller.healthCareAtHome,
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),
                          simpleSalonGrid(
                            "Fitness at Home",
                            controller,
                            context,
                            controller.fitness,
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),
                          simpleSalonGrid(
                            "Pet Care at Home",
                            controller,
                            context,
                            controller.petCare,
                          ),
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
  HomeScreenController controller,
  BuildContext context,
  List<Map<String, dynamic>> list, {
  Function(String)? onItemTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        titleName,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      SizedBox(
        height: AppStyle.heightPercent(
          context,
          13,
        ), // height of the horizontal grid
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = list[index];
            return InkWell(
              onTap: () {
                controller.appBarTitle.value = item['name'];
                Get.toNamed(
                  AppRoutes.subCategory,
                  arguments: controller.appBarTitle,
                );
              },
              child: Stack(
                children: [
                  // Image with dark overlay
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6), // smaller radius
                    child: Stack(
                      children: [
                        Image.asset(
                          item['image'],
                          width: 200,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: 200,
                          height: double.infinity,
                          color: Colors.black.withOpacity(0.4), // dark overlay
                        ),
                        Positioned(
                          bottom: 6,
                          left: 6,
                          child: SizedBox(
                            width: 110,
                            child: Text(
                              item['name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}
