import '../../../utils/app_export.dart';
import 'inbox_screen_controller.dart';

class InboxScreen extends StatelessWidget {
  InboxScreen({super.key});
  final controller = Get.put(InboxScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            // Chat Interface
            Expanded(child: Obx(() => _buildChatInterface(context))),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: AppStyle.heightPercent(context, 18),
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
            child: Column(
              children: [
                // Title and Online Status
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.inbox,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Obx(
                            () => Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: controller.adminIsOnline.value
                                        ? Colors.green
                                        : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  controller.adminIsOnline.value
                                      ? 'Admin is online'
                                      : 'Admin is offline',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                    fontFamily: AppFonts.fontFamily,
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
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColours.white,
                      child: const Text(
                        'A',
                        style: TextStyle(
                          color: AppColours.appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Admin Support',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColours.white,
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Obx(
                            () => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColours.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColours.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                controller.adminIsOnline.value
                                    ? 'Online now'
                                    : 'Last seen recently',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: controller.adminIsOnline.value
                                      ? Colors.green
                                      : Colors.grey[600],
                                  fontFamily: AppFonts.fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColours.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.phone,
                        color: AppColours.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInterface(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.appColor.withOpacity(0.1),
        // borderRadius: BorderRadius.circular(20),
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
          Expanded(child: _buildMessagesList()),
          // Typing Indicator
          Obx(
            () => controller.isTyping.value
                ? _buildTypingIndicator()
                : const SizedBox.shrink(),
          ),
          // Message Input
          _buildMessageInput(context),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: controller.scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final message = controller.messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isFromAdmin = message['isFromAdmin'];
    final timestamp = message['timestamp'] as DateTime;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isFromAdmin
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isFromAdmin) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColours.white,
              child: Text(
                'A',
                style: TextStyle(
                  color: AppColours.appColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isFromAdmin ? Colors.grey[100] : AppColours.appColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isFromAdmin ? 4 : 20),
                  bottomRight: Radius.circular(isFromAdmin ? 20 : 4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['text'],
                    style: TextStyle(
                      fontSize: 14,
                      color: isFromAdmin ? AppColours.black : Colors.white,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.formatMessageTime(timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: isFromAdmin ? Colors.grey[600] : Colors.white70,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isFromAdmin) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColours.appColor,
              child: Text(
                'Y',
                style: TextStyle(
                  color: AppColours.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColours.white,
            child: Text(
              'A',
              style: TextStyle(
                color: AppColours.appColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: AppColours.appColor.withOpacity(0.3 + (value * 0.7)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      height: AppStyle.heightPercent(context, 10),
      width: AppStyle.widthPercent(context, 100),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColours.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColours.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColours.grey),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(
                          color: AppColours.appColor,
                          fontFamily: AppFonts.fontFamily,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontFamily: AppFonts.fontFamily,
                        fontSize: 14,
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => controller.sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: controller.sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColours.appColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
