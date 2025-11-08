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
          SizedBox(height: AppStyle.heightPercent(context, 10)),
          SizedBox(
            width: AppStyle.widthPercent(context, 90),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.announcements,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                      SizedBox(height: AppStyle.heightPercent(context, 0.5)),
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
                GestureDetector(
                    onTap: (){
                      controller.showDeleteAllDialog(context,controller);
                    },
                    child: Icon(Icons.delete_forever,color: AppColours.white,)),
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

            child: _buildNotificationCard(notification, controller),
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
      ) {
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
          ),
        ],
        border: Border.all(
          color: AppColours.appColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Container(
          width: 48,
          height: 60,
          padding: const EdgeInsets.all(4),
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
        title: Text(
          notification.name ?? "",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.message ?? "",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontFamily: AppFonts.fontFamily,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text("${notification.dateTime}",style: TextStyle(fontFamily: AppFonts.fontFamily,fontSize: 12,color: AppColours.grey),),
                const Spacer(),
              notification.readStatus == 0 ?  GestureDetector(
                  onTap: () {
                    // Add your mark as read functionality here

                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColours.appColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      AppStrings.markReadAnnouncements,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ),
                ): SizedBox()
              ],
            ),
          ],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColours.appColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }


}
