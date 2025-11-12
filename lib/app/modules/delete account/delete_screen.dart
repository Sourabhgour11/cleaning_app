import 'package:cleaning_app/app/utils/custom_textformfield.dart';

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Obx(
            () => SizedBox(
              height: AppStyle.heightPercent(context, 100),
              width: AppStyle.widthPercent(context, 100),
              child: _buildContent(context, controller),
            ),
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
                   SizedBox(height: AppStyle.heightPercent(context, 2)),
                  _buildOtherReasonField(controller),
                   SizedBox(height: AppStyle.heightPercent(context, 2)),
                  _buildAgreementCheckbox(controller),
                   SizedBox(height: AppStyle.heightPercent(context, 2)),
                  _buildDeleteButton(controller),
                   SizedBox(height: AppStyle.heightPercent(context, 2)),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
          ),
        ],
      ),
      child: SafeArea( // ✅ Avoid notch issues
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double titleFontSize = width < 330 ? 18 : 22;
            double iconSize = width < 330 ? 34 : 40;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    // 🔙 Back Button
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
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
                          size: 18,
                        ),
                      ),
                    ),

                    // 🧱 Center Title (flexible)
                    Expanded(
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            AppStrings.deleteAccount,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: AppFonts.fontFamily,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Placeholder for balance
                    Opacity(
                      opacity: 0, // invisible but keeps spacing symmetric
                      child: Container(
                        padding: const EdgeInsets.all(8),
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
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // 🗑️ Delete Icon
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
                  child: Icon(
                    Icons.delete_forever,
                    size: iconSize,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                // 💬 Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppStrings.weAreSorryToSeeYouGo,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width < 330 ? 13 : 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
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
                  AppStrings.warning,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.thisActionIsPermanentAndCannotBeUndone,
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
            AppStrings.pleaseSpecifyYourReason,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColours.black,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          const SizedBox(height: 12),
          // TextField(
          //   maxLines: 4,
          //   onChanged: (value) => controller.otherReason.value = value,
          //   decoration: InputDecoration(
          //     hintText: 'Tell us more about why you\'re leaving...',
          //     hintStyle: TextStyle(
          //       color: Colors.grey[400],
          //       fontFamily: AppFonts.fontFamily,
          //     ),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: BorderSide(color: Colors.grey[300]!),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: const BorderSide(
          //         color: AppColours.appColor,
          //         width: 2,
          //       ),
          //     ),
          //     contentPadding: const EdgeInsets.all(16),
          //   ),
          // ),
          CustomTextFormField(
            maxLines: 4,
            hintText: "Tell us more about why you're leaving.",
            controller: controller.deleteController,
            onChanged: (value) => controller.otherReason.value = value,
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
                        AppStrings.deleteMyAccount,
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
