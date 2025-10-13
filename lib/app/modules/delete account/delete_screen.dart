import 'delete_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_export.dart';

class DeleteScreen extends StatelessWidget {
  const DeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeleteScreenController());

    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppStyle.heightPercent(context, 20)),
        child: _buildHeader(context, controller),
      ),
      body: SafeArea(
        child: Obx(
          () => SizedBox(
            height: AppStyle.heightPercent(context, 100),
            width: AppStyle.widthPercent(context, 100),
            child: _buildContent(context, controller),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    DeleteScreenController controller,
  ) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            color: AppColours.white,
            width: AppStyle.widthPercent(context, 90),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWarningCard(),
                  const SizedBox(height: 24),
                  // _buildAlternativeButton(controller),
                  // const SizedBox(height: 24),
                  // _buildReasonsSection(controller),
                  // const SizedBox(height: 24),
                  _buildOtherReasonField(controller),
                  const SizedBox(height: 24),

                  _buildAgreementCheckbox(controller),
                  const SizedBox(height: 24),
                  _buildDeleteButton(controller),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, DeleteScreenController controller) {
    return Container(
      width: AppStyle.widthPercent(context, 100),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red[700]!, Colors.red[900]!],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 12,
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
                'Delete Account',
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
          const SizedBox(height: 10),
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
            child: const Icon(
              Icons.delete_forever,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'We\'re Sorry to See You Go',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red[200]!, width: 2),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red[700], size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Warning!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'This action is permanent and cannot be undone',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.red[800],
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

  Widget _buildAlternativeButton(DeleteScreenController controller) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[400]!, Colors.blue[600]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.showAlternativeOptions,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Consider Alternatives',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Explore other options before deleting',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReasonsSection(DeleteScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Why are you leaving?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Select the main reason (required)',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontFamily: AppFonts.fontFamily,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: controller.deleteReasons.map((reason) {
              return _buildReasonOption(reason, controller);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReasonOption(
    Map<String, dynamic> reason,
    DeleteScreenController controller,
  ) {
    final isSelected = controller.selectedReason.value == reason['value'];

    return Material(
      color: isSelected ? AppColours.appColor.withOpacity(0.1) : Colors.white,
      child: InkWell(
        onTap: () => controller.selectReason(reason['value'] as String),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColours.appColor.withOpacity(0.2)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  reason['icon'] as IconData,
                  color: isSelected ? AppColours.appColor : Colors.grey[600],
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  reason['title'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? AppColours.appColor : AppColours.black,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: AppColours.appColor,
                  size: 22,
                )
              else
                Icon(
                  Icons.radio_button_unchecked,
                  color: Colors.grey[400],
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtherReasonField(DeleteScreenController controller) {
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
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Please specify your reason',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColours.black,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: 4,
            onChanged: (value) => controller.otherReason.value = value,
            decoration: InputDecoration(
              hintText: 'Tell us more about why you\'re leaving...',
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontFamily: AppFonts.fontFamily,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColours.appColor,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsequencesSection() {
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
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange[700], size: 24),
              const SizedBox(width: 12),
              const Text(
                'What You\'ll Lose',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColours.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildConsequenceItem(
            Icons.person_off,
            'Profile & Identity',
            'All personal information and verification',
          ),
          _buildConsequenceItem(
            Icons.star_border,
            'Ratings & Reviews',
            'Your hard-earned reputation and feedback',
          ),
          _buildConsequenceItem(
            Icons.history,
            'Job History',
            'Complete record of all completed jobs',
          ),
          _buildConsequenceItem(
            Icons.attach_money,
            'Earnings Data',
            'Financial history and statistics',
          ),
          _buildConsequenceItem(
            Icons.block,
            'Account Access',
            'Permanent loss of account access',
          ),
        ],
      ),
    );
  }

  Widget _buildConsequenceItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.red[700], size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColours.black,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
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

  Widget _buildAgreementCheckbox(DeleteScreenController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: controller.isAgreed.value
              ? AppColours.appColor
              : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.toggleAgreement,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: controller.isAgreed.value
                    ? AppColours.appColor
                    : Colors.white,
                border: Border.all(
                  color: controller.isAgreed.value
                      ? AppColours.appColor
                      : Colors.grey[400]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: controller.isAgreed.value
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: controller.toggleAgreement,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[800],
                    fontFamily: AppFonts.fontFamily,
                  ),
                  children: const [
                    TextSpan(text: 'I understand that '),
                    TextSpan(
                      text: 'this action is permanent',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(text: ' and I want to delete my account'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(DeleteScreenController controller) {
    final canProceed = controller.canProceed();

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: canProceed
            ? LinearGradient(colors: [Colors.red[700]!, Colors.red[900]!])
            : null,
        color: canProceed ? null : Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
        boxShadow: canProceed
            ? [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: canProceed ? controller.showFinalConfirmation : null,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: controller.isProcessing.value
                ? const CircularProgressIndicator(color: Colors.white)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_forever,
                        color: canProceed ? Colors.white : Colors.grey[500],
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Delete My Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: canProceed ? Colors.white : Colors.grey[500],
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
