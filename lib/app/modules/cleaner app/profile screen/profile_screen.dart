import '../../../utils/app_export.dart';
import 'profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileScreenController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(child: Obx(() => _buildContent(context, controller))),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ProfileScreenController controller,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header with Profile Info
          _buildProfileHeader(context, controller),
          const SizedBox(height: 20),
          // Statistics Cards
          _buildStatisticsCards(controller),
          const SizedBox(height: 20),
          // Menu Items
          _buildMenuItems(controller),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    ProfileScreenController controller,
  ) {
    return Container(
      height: AppStyle.heightPercent(context, 40),
      width: AppStyle.widthPercent(context, 100),
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
          const SizedBox(height: 20),
          // Profile Image and Edit Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 47,
                        backgroundImage: AssetImage(
                          controller.profileData['profileImage'] as String,
                        ),
                      
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Name and Verification
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        const SizedBox(width: 8),
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
                    const SizedBox(height: 8),
                    // Rating and Experience
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        const SizedBox(width: 16),
                        const Icon(Icons.work, color: Colors.white70, size: 16),
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
          const SizedBox(height: 20),
          // Availability Status
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  controller.profileData['availability'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '• ${controller.profileData['workingHours'] as String}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsCards(ProfileScreenController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Jobs',
              '${controller.profileData['totalJobs']}',
              Icons.work,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
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
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontFamily: AppFonts.fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(ProfileScreenController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
            .map((item) => _buildMenuItem(item, controller))
            .toList(),
      ),
    );
  }

  Widget _buildMenuItem(
    Map<String, dynamic> item,
    ProfileScreenController controller,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
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
