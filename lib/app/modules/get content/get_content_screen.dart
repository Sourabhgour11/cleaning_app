import 'get_content_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_export.dart';

class GetContentScreen extends StatelessWidget {
  const GetContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetContentScreenController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppStyle.heightPercent(context, 20)),
        child: _buildHeader(context, controller),
      ),
      body: SafeArea(child: Obx(() => _buildContent(context, controller))),
    );
  }

  Widget _buildContent(
    BuildContext context,
    GetContentScreenController controller,
  ) {
    if (controller.isLoading.value) {
      return _buildLoadingState(context, controller);
    }

    return Column(children: [Expanded(child: _buildContentBody(controller))]);
  }

  Widget _buildLoadingState(
    BuildContext context,
    GetContentScreenController controller,
  ) {
    return Column(
      children: [
        const Expanded(child: Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Widget _buildHeader(
      BuildContext context,
      GetContentScreenController controller,
      ) {
    IconData getHeaderIcon() {
      switch (controller.contentType.value) {
        case 'privacy':
          return Icons.privacy_tip;
        case 'terms':
          return Icons.description;
        case 'about':
          return Icons.info;
        default:
          return Icons.info;
      }
    }

    final width = AppStyle.widthPercent(context, 100);
    final height = AppStyle.heightPercent(context, 50); // fixed % of screen

    return Container(
      width: width,
      height: height, // bounded height to avoid RenderFlex issues
      padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.05),
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
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppStyle.heightPercent(context, 2)),
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
              Expanded(
                child: Obx(
                      () => Text(
                    controller.title.value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: AppFonts.fontFamily,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(width: 42), // same width as back button
            ],
          ),
          SizedBox(height: height * 0.015),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(getHeaderIcon(), size: 40, color: Colors.white),
          ),
        ],
      ),
    );
  }


  Widget _buildContentBody(GetContentScreenController controller) {
    return Container(
      margin: const EdgeInsets.all(16),
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: _buildFormattedContent(controller.content.value),
      ),
    );
  }

  Widget _buildFormattedContent(String content) {
    // Split content into paragraphs
    final paragraphs = content.split('\n\n');
    final List<Widget> widgets = [];

    for (final paragraph in paragraphs) {
      if (paragraph.trim().isEmpty) continue;

      // Check if it's a heading (starts with **)
      if (paragraph.startsWith('**') && paragraph.endsWith('**')) {
        final heading = paragraph.replaceAll('**', '').trim();
        widgets.add(_buildHeading(heading));
        widgets.add(const SizedBox(height: 12));
      }
      // Check if it's a bullet point
      else if (paragraph.startsWith('•')) {
        final bullets = paragraph.split('\n');
        for (final bullet in bullets) {
          if (bullet.trim().isNotEmpty) {
            widgets.add(_buildBulletPoint(bullet.trim()));
            widgets.add(const SizedBox(height: 8));
          }
        }
        widgets.add(const SizedBox(height: 8));
      }
      // Regular paragraph
      else {
        // Handle inline bold text
        widgets.add(_buildParagraph(paragraph.trim()));
        widgets.add(const SizedBox(height: 16));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildHeading(String text) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColours.appColor, width: 2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: AppColours.appColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColours.appColor,
                fontFamily: AppFonts.fontFamily,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    // Remove the bullet point character if present
    final cleanText = text.startsWith('•') ? text.substring(1).trim() : text;

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColours.appColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              cleanText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.6,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParagraph(String text) {
    // Check if text contains bold markers
    if (text.contains('**')) {
      return _buildParagraphWithBold(text);
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[800],
        height: 1.7,
        fontFamily: AppFonts.fontFamily,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildParagraphWithBold(String text) {
    final List<TextSpan> spans = [];
    final regex = RegExp(r'\*\*(.*?)\*\*');
    int lastIndex = 0;

    for (final match in regex.allMatches(text)) {
      // Add text before the bold part
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.7,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        );
      }

      // Add bold text
      spans.add(
        TextSpan(
          text: match.group(1),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
            height: 1.7,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
      );

      lastIndex = match.end;
    }

    // Add remaining text
    if (lastIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[800],
            height: 1.7,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(children: spans),
      textAlign: TextAlign.justify,
    );
  }
}
