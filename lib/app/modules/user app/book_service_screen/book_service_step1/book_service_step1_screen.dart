import 'package:cleaning_app/app/utils/app_export.dart';
import 'book_service_step1_screen_controller.dart';

class BookServiceStep1Screen extends StatelessWidget {
  const BookServiceStep1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookServiceStep1ScreenController controller = Get.put(
      BookServiceStep1ScreenController(),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppStyle.appBarStyle(controller.appBarTitle.value),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: SingleChildScrollView(
          // padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppStyle.heightPercent(context, 1.5)),
              Text(
                'Step 1 of 3',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              // Exclusive Offer Section
              _buildExclusiveOffer(controller),

              SizedBox(height: AppStyle.heightPercent(context, 3)),

              // Service Duration Section
              _buildServiceDuration(controller),

              SizedBox(height: AppStyle.heightPercent(context, 3)),

              // Professionals Count Section
              _buildProfessionalsCount(controller),

              SizedBox(height: AppStyle.heightPercent(context, 3)),

              // Cleaning Materials Section
              _buildCleaningMaterials(controller),

              SizedBox(height: AppStyle.heightPercent(context, 3)),

              // Specific Instructions Section
              _buildSpecificInstructions(controller),

              SizedBox(
                height: AppStyle.heightPercent(context, 15),
              ), // Bottom padding for footer
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildFooter(controller, context),
    );
  }

  Widget _buildExclusiveOffer(BookServiceStep1ScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.exclusiveOfferForYou,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.diamond, color: Colors.orange, size: 24),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      controller.offerAmount.value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(
                    () => Text(
                      'Code: ${controller.offerCode.value}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Obx(
                () => ElevatedButton(
                  onPressed: controller.applyOffer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isOfferActive
                        ? Colors.green
                        : AppColours.appColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    controller.offerDisplayText,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceDuration(BookServiceStep1ScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: const Text(
                AppStrings.howManyHoursDoYouNeedYourProfessionalToStay,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ),

            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.info_outline,
                size: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.availableHours.map((hours) {
                final isSelected = controller.selectedHours.value == hours;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () => controller.selectHours(hours),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColours.appColor
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? AppColours.appColor
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          hours.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black,
                            fontFamily: AppFonts.fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfessionalsCount(BookServiceStep1ScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.howManyProfessionalsDoYouNeed,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
        const SizedBox(height: 16),
        Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.availableProfessionals.map((count) {
                final isSelected =
                    controller.selectedProfessionals.value == count;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () => controller.selectProfessionals(count),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColours.appColor
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? AppColours.appColor
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          count.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black,
                            fontFamily: AppFonts.fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCleaningMaterials(BookServiceStep1ScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              AppStrings.needCleaningMaterials,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.info_outline,
                size: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => GestureDetector(
                  onTap: () => controller.toggleCleaningMaterials(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: !controller.needsCleaningMaterials.value
                          ? AppColours.appColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.noIHaveThem,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: !controller.needsCleaningMaterials.value
                              ? Colors.white
                              : Colors.grey[600],
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Obx(
                () => GestureDetector(
                  onTap: () => controller.toggleCleaningMaterials(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: controller.needsCleaningMaterials.value
                          ? AppColours.appColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.yesPlease,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: controller.needsCleaningMaterials.value
                              ? Colors.white
                              : Colors.grey[600],
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecificInstructions(
    BookServiceStep1ScreenController controller,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => Text(
                controller.hasInstructions.value
                    ? controller.specificInstructions.value
                    : AppStrings.anySpecificInstructions,
                style: TextStyle(
                  fontSize: 14,
                  color: controller.hasInstructions.value
                      ? Colors.black
                      : Colors.grey[600],
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: controller.addInstructions,
            child: const Text(
              'Add',
              style: TextStyle(
                color: AppColours.appColor,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(
    BookServiceStep1ScreenController controller,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, -2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.total,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Obx(
                      () => Text(
                        controller.getFormattedPrice(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        controller.showBookingSummaryBottomSheet(context);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            height: AppStyle.heightPercent(context, 5),
            width: AppStyle.widthPercent(context, 30),
            child: AppButton(
              onPressed: () {
                Get.toNamed(
                  AppRoutes.bookServiceStep2,
                  arguments: controller.appBarTitle,
                );
              },
              title: AppStrings.next,
            ),
          ),
        ],
      ),
    );
  }
}
