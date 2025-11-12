import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/app/data/models/get_notification_model.dart';
import 'package:cleaning_app/app/utils/app_url.dart';

import '../../../utils/app_export.dart';
import 'announcement_screen_controller.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnnouncementScreenController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppStyle.heightPercent(context, 13)),
        child: _buildHeader(context, controller),
      ),
      body: SafeArea(
        child: SizedBox(
          width: AppStyle.widthPercent(context, 100),
          height: AppStyle.heightPercent(context, 100),
          child: Column(
            children: [
              // Header
              // _buildHeader(context, controller),
              const SizedBox(height: 15),
              // Content
              Expanded(child: Obx(() => _buildContent(controller, context))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AnnouncementScreenController controller,
  ) {
    return Container(
      height: AppStyle.heightPercent(context, 20),
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
          SizedBox(height: AppStyle.heightPercent(context, 8)),
          SizedBox(
            width: AppStyle.widthPercent(context, 90),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Dynamically adjust font size based on available width
                double width = constraints.maxWidth;
                double titleFontSize = width < 340 ? 20 : 24;
                double subtitleFontSize = width < 340 ? 12 : 14;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 🧱 Text Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              AppStrings.announcements,
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: AppFonts.fontFamily,
                              ),
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 0.5)),
                          Obx(
                                () => Text(
                              '${controller.unreadCount} unread announcements',
                              overflow: TextOverflow.ellipsis, // ✅ Prevents overflow
                              style: TextStyle(
                                fontSize: subtitleFontSize,
                                color: Colors.white70,
                                fontFamily: AppFonts.fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🗑️ Delete Icon
                    SizedBox(width: 8), // small space before icon
                    GestureDetector(
                      onTap: () {
                        controller.showDeleteAllDialog(context, controller);
                      },
                      child: const Icon(
                        Icons.delete_forever,
                        color: AppColours.white,
                        size: 26,
                      ),
                    ),
                  ],
                );
              },
            ),
          )

        ],
      ),
    );
  }

  Widget _buildContent(
      AnnouncementScreenController controller,
      BuildContext context,
      ) {
    final notifications = controller.notificationData;

    if (notifications.value?.notificationArr?.isEmpty ?? true) {
      return _buildEmptyState(context);
    }

    return SizedBox(
      width: AppStyle.widthPercent(context, 90),
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: AppStyle.heightPercent(context, 10)),
        itemCount: notifications.value?.notificationArr?.length ?? 0,
        itemBuilder: (context, index) {
          final notification = notifications.value!.notificationArr![index];

          return Dismissible(
            key: ValueKey(notification.notificationMessageId ?? index),
            direction: DismissDirection.endToStart, // swipe from right to left
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 28,
              ),
            ),
            onDismissed: (direction) async {
              final notificationId = controller.notificationData.value
                  ?.notificationArr?[index].notificationMessageId;

              // Convert it to String (even if it's int or null)
              final idAsString = notificationId?.toString() ?? "";

              // 🔹 Call your delete API
              await controller.deleteSingleNotificationApi(idAsString);

              // 🔹 Remove from local list (reactive update)
              notifications.value!.notificationArr!.removeAt(index);
              notifications.refresh();

              // 🔹 Show feedback
              Get.snackbar(
                "Deleted",
                "Notification deleted successfully",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.redAccent.withOpacity(0.8),
                colorText: Colors.white,
              );
            },

            child: _buildNotificationCard(notification, controller,context),
          );
        },
      ),
    );

  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            AppStrings.noAnnouncements,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.newAnnouncementsWillAppearHere,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          SizedBox(height: AppStyle.heightPercent(context, 10),),
        ],
      ),
    );
  }
  Widget _buildNotificationCard(
      NotificationArr notification,
      AnnouncementScreenController controller,
      BuildContext context, // Pass context for responsive sizing
      ) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015), // responsive margin
      padding: EdgeInsets.all(screenWidth * 0.03), // responsive padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
        border: Border.all(
          color: AppColours.appColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Leading Image
          Container(
            width: screenWidth * 0.13, // responsive width
            height: screenWidth * 0.16, // responsive height
            padding: EdgeInsets.all(screenWidth * 0.01),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: AppUrl.imageUrl + (notification.userImage ?? ''),
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
          ),

          SizedBox(width: screenWidth * 0.03),

          // Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  notification.name ?? "",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: AppColours.black,
                    fontFamily: AppFonts.fontFamily,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenHeight * 0.005),

                // Message
                Text(
                  notification.message ?? "",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[700],
                    fontFamily: AppFonts.fontFamily,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: screenHeight * 0.012),

                // Row with Date & Mark as Read button
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${notification.dateTime}",
                        style: TextStyle(
                          fontFamily: AppFonts.fontFamily,
                          fontSize: screenWidth * 0.03,
                          color: AppColours.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    if (notification.readStatus == 0)
                      GestureDetector(
                        onTap: () {
                          // Add mark as read functionality
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.008,
                          ),
                          decoration: BoxDecoration(
                            color: AppColours.appColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            AppStrings.markReadAnnouncements,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.03,
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
          ),

          // Trailing dot
          if (notification.readStatus == 0)
            Container(
              width: screenWidth * 0.025,
              height: screenWidth * 0.025,
              margin: EdgeInsets.only(left: screenWidth * 0.02),
              decoration: const BoxDecoration(
                color: AppColours.appColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }



}
