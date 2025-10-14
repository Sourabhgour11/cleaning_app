import '../../../utils/app_export.dart';
import 'profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileScreenController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppStyle.heightPercent(context, 20)),
        child: _buildProfileHeader(context, controller),
      ),
      body: SafeArea(child: Obx(() => _buildContent(context, controller))),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ProfileScreenController controller,
  ) {
    return SingleChildScrollView(
      child: SizedBox(
        width: AppStyle.widthPercent(context, 100),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Statistics Cards
            _buildStatisticsCards(context, controller),
            const SizedBox(height: 20),
            // Menu Items
            _buildMenuItems(context, controller),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    ProfileScreenController controller,
  ) {
    return Container(
      height: AppStyle.heightPercent(context, 20),
      width: AppStyle.widthPercent(context, 100),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: AppColours.gradientColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: AppStyle.heightPercent(context, 4)),
          // Profile Image and Edit Button
          SizedBox(
            width: AppStyle.widthPercent(context, 90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      controller.profileData['profileImage'] as String,
                    ),
                  ),
                ),
                SizedBox(
                  width: AppStyle.widthPercent(context, 67),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppStyle.heightPercent(context, 0.5)),
                      // Name and Verification
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            controller.profileData['name'] as String,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                          SizedBox(width: AppStyle.widthPercent(context, 2)),
                          if (controller.profileData['isVerified'] as bool)
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.profileData['email'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                      SizedBox(height: AppStyle.heightPercent(context, 0.5)),
                      // Rating and Experience
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${controller.profileData['rating'] as double}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                          SizedBox(width: AppStyle.widthPercent(context, 2)),
                          const Icon(
                            Icons.work,
                            color: Colors.white70,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            controller.profileData['experience'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppStyle.heightPercent(context, 2)),
        ],
      ),
    );
  }

  Widget _buildStatisticsCards(
    BuildContext context,
    ProfileScreenController controller,
  ) {
    return SizedBox(
      width: AppStyle.widthPercent(context, 90),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              context,
              'Total Jobs',
              '${controller.profileData['totalJobs']}',
              Icons.work,
              Colors.blue,
            ),
          ),
          SizedBox(width: AppStyle.widthPercent(context, 2)),
          Expanded(
            child: _buildStatCard(
              context,
              'Completed',
              '${controller.profileData['completedJobs']}',
              Icons.check_circle,
              Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: AppStyle.widthPercent(context, 90),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: AppStyle.heightPercent(context, 2)),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: AppStyle.heightPercent(context, 0.5)),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          SizedBox(height: AppStyle.heightPercent(context, 0.5)),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontFamily: AppFonts.fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppStyle.heightPercent(context, 2)),
        ],
      ),
    );
  }

  Widget _buildMenuItems(
    BuildContext context,
    ProfileScreenController controller,
  ) {
    return Container(
      width: AppStyle.widthPercent(context, 90),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: controller.menuItems
            .map((item) => _buildMenuItem(context, item, controller))
            .toList(),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    Map<String, dynamic> item,
    ProfileScreenController controller,
  ) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(AppStyle.heightPercent(context, 0.5)),
        decoration: BoxDecoration(
          color: (item['color'] as Color).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          item['icon'] as IconData,
          color: item['color'] as Color,
          size: 20,
        ),
      ),
      title: Text(
        item['title'] as String,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColours.black,
          fontFamily: AppFonts.fontFamily,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () => controller.handleMenuAction(item['action'] as String),
    );
  }
}
