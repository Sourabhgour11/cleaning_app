import 'help_and_support_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_export.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpAndSupportScreenController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppStyle.heightPercent(context, 30)),
        child: _buildHeader(context),
      ),
      body: SafeArea(child: Obx(() => _buildContent(context, controller))),
    );
  }

  Widget _buildContent(
    BuildContext context,
    HelpAndSupportScreenController controller,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          // FAQs Section
          _buildFaqSection(controller),
          const SizedBox(height: 24),
          // Contact Information
          _buildContactSection(controller),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: AppStyle.widthPercent(context, 100),
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const Text(
                'Help & Support',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: AppFonts.fontFamily,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 42),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: AppStyle.widthPercent(context, 60),
            height: AppStyle.heightPercent(context, 18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.support_agent,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'We\'re Here to Help!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Get assistance with any questions or issues',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.9),
                    fontFamily: AppFonts.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqSection(HelpAndSupportScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.quiz, color: AppColours.appColor, size: 24),
              SizedBox(width: 8),
              Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColours.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
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
            children: List.generate(
              controller.faqItems.length,
              (index) =>
                  _buildFaqItem(controller.faqItems[index], index, controller),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFaqItem(
    Map<String, dynamic> faq,
    int index,
    HelpAndSupportScreenController controller,
  ) {
    final isExpanded = controller.expandedFaqIndex.value == index;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          onExpansionChanged: (expanded) {
            if (expanded) {
              controller.toggleFaq(index);
            } else {
              controller.expandedFaqIndex.value = -1;
            }
          },
          initiallyExpanded: isExpanded,
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColours.appColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isExpanded ? Icons.remove : Icons.add,
              color: AppColours.appColor,
              size: 20,
            ),
          ),
          title: Text(
            faq['question'] as String,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isExpanded ? AppColours.appColor : AppColours.black,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
                top: 0,
              ),
              child: Text(
                faq['answer'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                  height: 1.5,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(HelpAndSupportScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.contact_support, color: AppColours.appColor, size: 24),
              SizedBox(width: 8),
              Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColours.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
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
            children: controller.contactMethods.map((method) {
              return _buildContactItem(method, controller);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(
    Map<String, dynamic> method,
    HelpAndSupportScreenController controller,
  ) {
    IconData getIcon(String iconName) {
      switch (iconName) {
        case 'phone':
          return Icons.phone;
        case 'email':
          return Icons.email;
        case 'time':
          return Icons.access_time;
        case 'emergency':
          return Icons.emergency;
        default:
          return Icons.info;
      }
    }

    final icon = getIcon(method['icon'] as String);
    final type = method['type'] as String;

    return GestureDetector(
      onTap: type != 'info'
          ? () =>
                controller.handleContactMethod(type, method['value'] as String)
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColours.appColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColours.appColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method['title'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColours.black,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    method['value'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: type != 'info'
                          ? AppColours.appColor
                          : Colors.grey[600],
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                ],
              ),
            ),
            if (type != 'info')
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalResources() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.library_books, color: AppColours.appColor, size: 24),
              SizedBox(width: 8),
              Text(
                'Additional Resources',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColours.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
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
            children: [
              _buildResourceItem(
                'About Us',
                'Learn about our platform',
                Icons.info,
                Colors.blue,
              ),
              _buildResourceItem(
                'Terms & Conditions',
                'Read our terms of service',
                Icons.description,
                Colors.orange,
              ),
              _buildResourceItem(
                'Privacy Policy',
                'Learn about data protection',
                Icons.privacy_tip,
                Colors.green,
              ),
              _buildResourceItem(
                'Video Tutorials',
                'Watch helpful video guides',
                Icons.play_circle_outline,
                Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResourceItem(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    String getContentType(String title) {
      if (title.contains('Privacy')) return 'privacy';
      if (title.contains('Terms')) return 'terms';
      return 'about';
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColours.black,
          fontFamily: AppFonts.fontFamily,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          fontFamily: AppFonts.fontFamily,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: () {
        // Navigate to GetContentScreen for Privacy Policy, Terms, and About
        if (title.contains('Privacy') ||
            title.contains('Terms') ||
            title.contains('About')) {
          Get.toNamed(
            AppRoutes.getContent,
            arguments: {'type': getContentType(title)},
          );
        } else {
          Get.snackbar(
            title,
            'Opening $title...',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
    );
  }
}
