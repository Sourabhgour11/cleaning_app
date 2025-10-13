import '../../../utils/app_export.dart';
import 'announcement_screen_controller.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnnouncementScreenController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context, controller),
            const SizedBox(height: 15),
            // Content
            Expanded(child: Obx(() => _buildContent(controller, context))),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AnnouncementScreenController controller,
  ) {
    return Container(
      height: AppStyle.heightPercent(context, 15),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: AppStyle.widthPercent(context, 90),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(

                        'Announcements',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => Text(
                          '${controller.unreadCount} unread announcements',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontFamily: AppFonts.fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    AnnouncementScreenController controller,
    BuildContext context,
  ) {
    final notifications = controller.notifications;

    if (notifications.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 80),
      width: AppStyle.widthPercent(context, 90),

      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return _buildNotificationCard(notifications[index], controller);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No announcements',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'New announcements will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    Map<String, dynamic> notification,
    AnnouncementScreenController controller,
  ) {
    final isRead = notification['isRead'];
    final timestamp = notification['timestamp'] as DateTime;
    final icon = notification['icon'] as IconData;
    final color = notification['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
        border: isRead
            ? null
            : Border.all(color: AppColours.appColor.withOpacity(0.3), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          notification['title'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification['message'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontFamily: AppFonts.fontFamily,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  controller.formatTime(timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const Spacer(),
                if (!isRead)
                  GestureDetector(
                    onTap: () => controller.markAsRead(notification['id']),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColours.appColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Mark Read Announcement',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        trailing: !isRead
            ? Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColours.appColor,
                  shape: BoxShape.circle,
                ),
              )
            : null,
      ),
    );
  }
}
