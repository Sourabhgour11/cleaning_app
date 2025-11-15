import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step1/book_service_step1_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:intl/intl.dart';
import 'book_service_step2_screen_controller.dart';

class BookServiceStep2Screen extends StatelessWidget {
  BookServiceStep2Screen({super.key});

  final bookServiceStep1Controllerr =
      Get.find<BookServiceStep1ScreenController>();

  final BookServiceStep2ScreenController controller = Get.put(BookServiceStep2ScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookServiceStep2ScreenController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColours.white,
          appBar: AppStyle.appBarStyle(controller.appBarTitle.value),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppStyle.heightPercent(context, 1.5)),
                  Text(
                    'Step 2 of 3',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                  SizedBox(height: AppStyle.heightPercent(context, 1)),

                  _buildFrequencySection(context),
                  SizedBox(height: AppStyle.heightPercent(context, 2)),
                  // Date Selection Section
                  _buildDateSection(context,controller),

                  SizedBox(height: AppStyle.heightPercent(context, 2)),

                  // Time Selection Section
                  _buildTimeSection(controller),

                  SizedBox(height: AppStyle.heightPercent(context, 1.5)),

                  // Cancellation Policy
                  _buildCancellationPolicy(context),

                  SizedBox(height: AppStyle.heightPercent(context, 1.5)),

                  // Specific Instructions
                  _buildSpecificInstructions(controller, context),

                  SizedBox(
                    height: AppStyle.heightPercent(context, 15),
                  ), // Space for fixed footer
                ],
              ),
            ),
          ),

          // Fixed footer
          bottomNavigationBar: _buildFooter(
            controller,
            context,
            bookServiceStep1Controllerr,
          ),
        );
      },
    );
  }

  Widget _buildFrequencySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.dateAndTime,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),

        const SizedBox(height: 16),
        GestureDetector(
          onTap: (){
      controller.showWeekdayDialog(controller);
          },
          child: Container(
            height: AppStyle.heightPercent(context, 8),
            width: AppStyle.widthPercent(context, 90),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColours.appColor),
              color: AppColours.appColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppStyle.widthPercent(context, 85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.fgrequency,
                        style: TextStyle(
                          color: AppColours.black,
                          fontSize: 15,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text(
                        AppStrings.change,
                        style: TextStyle(
                          color: AppColours.appColor,
                          fontFamily: AppFonts.fontFamily,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColours.appColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: AppStyle.heightPercent(context, 3),
                  width: AppStyle.widthPercent(context, 35),
                  decoration: BoxDecoration(
                    color: AppColours.appColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.repeat, size: 15, color: AppColours.white),
                      SizedBox(width: 2),
                      Text(
                        AppStrings.Repeats,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: AppFonts.fontFamily,
                          color: AppColours.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSection(BuildContext context,BookServiceStep2ScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: controller.availableDates.map((date) {
            return Text(
              date['dayName'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontFamily: AppFonts.fontFamily,
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 8),

        // Date buttons row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: controller.availableDates.asMap().entries.map((entry) {
            final index = entry.key;
            final date = entry.value;
            final isSelected = controller.selectedDateIndex.value == index;

            return GestureDetector(
              // onTap: () => controller.selectDate(index),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? AppColours.appColor : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColours.appColor : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${date['date']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColours.white : AppColours.black,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        // weekCalendar(context,controller),
        weekCalendar(context, controller)

      ],
    );
  }

  Widget _buildTimeSection(BookServiceStep2ScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(width: AppStyle.heightPercent(context, 30.5),
            const Text(
              AppStrings.whatTimeWouldYouLikeUsToStart,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColours.black,
                fontFamily: AppFonts.fontFamily,
              ),
            ),

            GestureDetector(
              onTap: () {
                // TODO: Show all time slots
              },
              child: const Text(
                AppStrings.seeAll,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColours.appColor,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Time slots
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: controller.timeSlots.map((timeSlot) {
            final isSelected =
                controller.selectedTimeSlotId.value == timeSlot.id;

            return GestureDetector(
              onTap: () => controller.selectTimeSlot(timeSlot.id),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColours.appColor : AppColours.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? AppColours.appColor : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Text(
                  timeSlot.timeRange,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? AppColours.white : AppColours.black,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCancellationPolicy(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColours.appColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline,
              color: AppColours.white,
              size: 16,
            ),
          ),

          const SizedBox(width: 12),

          SizedBox(
            width: AppStyle.heightPercent(context, 28),
            child: Text(
              'Enjoy free cancellation up to 6 hours before your booking start time.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ),
          Spacer(),

          GestureDetector(
            onTap: () {
              // TODO: Show cancellation details
            },
            child: const Text(
              AppStrings.details,
              style: TextStyle(
                fontSize: 14,
                color: AppColours.appColor,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificInstructions(
    BookServiceStep2ScreenController controller,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.anySpecificInstructions,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColours.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),

              GestureDetector(
                onTap: () {
                  controller.showAdditionalInstructionsBottomSheet(context);
                },
                child: Text(
                  controller.instructionsController.text == "" ? 'Add' : 'Edit',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColours.appColor,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ),
            ],
          ),
          controller.instructionsController.text.isNotEmpty
              ? Text(controller.instructionsController.text)
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildFooter(
    BookServiceStep2ScreenController controller,
    BuildContext context,
    BookServiceStep1ScreenController bookServiceController,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Total section
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
                        'AED ${controller.baseServicePrice.toStringAsFixed(2)}',
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
                        bookServiceController.showBookingSummaryBottomSheet(
                          context,
                        );
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

          // Next button
          SizedBox(
            height: AppStyle.heightPercent(context, 5),
            width: AppStyle.widthPercent(context, 30),
            child: AppButton(
              onPressed: () {
                Get.toNamed(
                  AppRoutes.bookServiceStep3,
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

Widget weekCalendar(BuildContext context, BookServiceStep2ScreenController controller) {
  double screenWidth = MediaQuery.of(context).size.width;
  double circleSize = screenWidth * 0.110;
  double spacing = screenWidth * 0.02;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "When would you like your service?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: spacing),

        SizedBox(
          height: circleSize + 20 + spacing,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.weekDates.length,
            itemBuilder: (context, index) {
              DateTime date = controller.weekDates[index];

              bool isSelected = controller.selectedDate.value?.day == date.day &&
                  controller.selectedDate.value?.month == date.month &&
                  controller.selectedDate.value?.year == date.year;

              // Check if this day matches any selected weekday
              bool isHighlighted = controller.selectedWeekdays.contains(date.weekday);

              return GestureDetector(
                onTap: () => controller.selectDate(date),
                child: Container(
                  width: circleSize,
                  margin: EdgeInsets.symmetric(horizontal: spacing / 2),
                  child: Column(
                    children: [
                      // WEEKDAY
                      Text(
                        DateFormat("E").format(date).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spacing / 2),

                      // DATE CIRCLE
                      Container(
                        width: circleSize,
                        height: circleSize,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.teal
                              : isHighlighted
                              ? Colors.teal.withOpacity(0.5)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected || isHighlighted
                                ? Colors.teal
                                : Colors.black26,
                            width: 1.6,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected || isHighlighted
                                ? Colors.white
                                : Colors.black87,
                            fontSize: circleSize * 0.4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }



