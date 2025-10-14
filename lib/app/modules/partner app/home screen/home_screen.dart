import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'home_screen_controller.dart';

class PartnerHomeScreen extends StatelessWidget {
  PartnerHomeScreen({super.key});

  final PartnerHomeScreenController controller = Get.put(
    PartnerHomeScreenController(),
  );
  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: SizedBox(
        width: AppStyle.widthPercent(context, 100),
        child: CustomScrollView(
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
                  bool isCollapsed = top < 120; // adjust threshold as needed

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      // Gradient Background
                      Container(
                        decoration: BoxDecoration(
                          gradient: AppColours.gradientColor,
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
                                  "😊 Good afternoon, ${controller.userName.value}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFonts.fontFamily,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
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
                                      width: AppStyle.widthPercent(context, 60),
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
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
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
                                    hintStyle: TextStyle(color: Colors.grey),
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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
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
                        // viewportFraction: 0.9,
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
                            onTap: () =>
                                carouselController.animateToPage(entry.key),
                            child: Container(
                              width: controller.currentIndex.value == entry.key
                                  ? 8
                                  : 6,
                              height: controller.currentIndex.value == entry.key
                                  ? 8
                                  : 6,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    controller.currentIndex.value == entry.key
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
            // Jobs Filter Banner
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: _buildJobsFilterBanner(),
              ),
            ),
            // Jobs List Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: _buildJobsListSection(),
              ),
            ),
            // Extra space for floating tab bar
            SliverToBoxAdapter(child: const SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  // Cleaner Dashboard Section
  Widget _buildPartnerDashboard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColours.appColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.work_outline,
                  color: AppColours.appColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColours.black,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ready to clean and earn?',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColours.grey,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Quick Stats Grid - Better looking compact version
  Widget _buildQuickStatsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Performance',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColours.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // First row - Earnings and Jobs
              Row(
                children: [
                  Expanded(
                    child: _buildCompactStatCard(
                      'Earnings',
                      '₹${controller.totalEarnings.value}',
                      Icons.currency_rupee,
                      Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCompactStatCard(
                      'Jobs Done',
                      '${controller.completedJobs.value}',
                      Icons.check_circle,
                      Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Second row - Rating and Upcoming
              Row(
                children: [
                  Expanded(
                    child: _buildCompactStatCard(
                      'Rating',
                      '${controller.rating.value} ⭐',
                      Icons.star,
                      Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCompactStatCard(
                      'Upcoming',
                      '${controller.upcomingBookings.value}',
                      Icons.schedule,
                      Colors.purple,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Compact Stat Card Widget
  Widget _buildCompactStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColours.black,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: AppColours.grey,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  // Recent Jobs Section
  Widget _buildRecentJobs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Jobs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
        // const SizedBox(height: 4),
        Obx(
          () => controller.completedJobsList.isEmpty
              ? _buildEmptyJobsState()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.completedJobsList.length,
                  itemBuilder: (context, index) {
                    final job = controller.completedJobsList[index];
                    return _buildJobCard(job);
                  },
                ),
        ),
      ],
    );
  }

  // Empty Jobs State
  Widget _buildEmptyJobsState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.work_outline, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No jobs completed yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColours.grey,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete your first cleaning job to see it here',
            style: TextStyle(
              fontSize: 12,
              color: AppColours.grey,
              fontFamily: AppFonts.fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Jobs List Section Widget
  Widget _buildJobsListSection() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  '${controller.jobFilterOptions[controller.selectedJobFilter.value]} Jobs',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColours.black,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const Spacer(),
                Text(
                  '${controller.currentJobsList.length} items',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColours.grey,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Jobs List
          if (controller.currentJobsList.isEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColours.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColours.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.work_off_outlined,
                    size: 48,
                    color: AppColours.grey.withOpacity(0.6),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No ${controller.jobFilterOptions[controller.selectedJobFilter.value].toLowerCase()} jobs',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColours.grey,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your ${controller.jobFilterOptions[controller.selectedJobFilter.value].toLowerCase()} jobs will appear here',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColours.grey.withOpacity(0.7),
                      fontFamily: AppFonts.fontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ...controller.currentJobsList
                .map((job) => _buildJobCard(job))
                .toList(),
        ],
      ),
    );
  }

  // Individual Job Card Widget
  Widget _buildJobCard(Map<String, dynamic> job) {
    String status = job['status'];
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'upcoming':
        statusColor = Colors.blue;
        statusIcon = Icons.schedule;
        break;
      case 'pending':
        statusColor = Colors.orange;
        statusIcon = Icons.pending;
        break;
      case 'completed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      default:
        statusColor = AppColours.grey;
        statusIcon = Icons.help_outline;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColours.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: statusColor.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(statusIcon, color: statusColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColours.black,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      job['client'],
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColours.grey,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Location and Amount Row
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColours.grey,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  job['location'],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColours.grey,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Date/Time Row
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: AppColours.grey),
              const SizedBox(width: 4),
              Text(
                job['date'],
                style: TextStyle(
                  fontSize: 14,
                  color: AppColours.grey,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Jobs Filter Banner Widget
  Widget _buildJobsFilterBanner() {
    return Container(
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColours.appColor.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColours.appColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColours.appColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.work_outline,
                    color: AppColours.appColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'My Jobs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColours.black,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const Spacer(),
                Obx(
                  () => Text(
                    '${controller.currentJobsList.length} jobs',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColours.grey,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Filter Tabs
          Obx(
            () => Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColours.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: controller.jobFilterOptions.asMap().entries.map((
                  entry,
                ) {
                  int index = entry.key;
                  String option = entry.value;
                  bool isSelected = controller.selectedJobFilter.value == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changeJobFilter(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColours.appColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          option,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? AppColours.white
                                : AppColours.grey,
                            fontFamily: AppFonts.fontFamily,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// Simple version without colors
Widget simpleSalonGrid(
  String titleName,
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
        height: 120, // height of the horizontal grid
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = list[index];
            return InkWell(
              onTap: () {
                if (onItemTap != null) {
                  onItemTap("Item $index");
                }
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
                          bottom: 8,
                          left: 8,
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
