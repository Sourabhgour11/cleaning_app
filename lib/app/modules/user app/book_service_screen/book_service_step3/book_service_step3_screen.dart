import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step1/book_service_step1_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'book_service_step3_screen_controller.dart';

class BookServiceStep3Screen extends StatelessWidget {
  BookServiceStep3Screen({super.key});

  final bookServiceStep1Controllerr =
      Get.find<BookServiceStep1ScreenController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookServiceStep3ScreenController>(
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
                  const SizedBox(height: 20),

                  // Professional Selection Section
                  // _buildProfessionalSection(controller),

                  // const SizedBox(height: 32),

                  // Date Selection Section
                  _buildDateSection(controller),

                  const SizedBox(height: 32),

                  // Time Selection Section
                  _buildTimeSection(controller),

                  const SizedBox(height: 24),

                  // Cancellation Policy
                  _buildCancellationPolicy(),

                  const SizedBox(height: 24),

                  // Specific Instructions
                  _buildSpecificInstructions(controller, context),

                  const SizedBox(height: 100), // Space for fixed footer
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

  // Widget _buildProfessionalSection(BookServiceStep3ScreenController controller) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Which professional do you prefer?',
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.w600,
  //           color: AppColours.black,
  //           fontFamily: AppFonts.fontFamily,
  //         ),
  //       ),
  //
  //       const SizedBox(height: 16),
  //
  //       // // Professional cards
  //       // ...controller.professionals.map((professional) =>
  //       //   _buildProfessionalCard(professional, controller)
  //       // ).toList(),
  //     ],
  //   );
  // }

  // Widget _buildProfessionalCard(Professional professional, BookServiceStep3ScreenController controller) {
  //   final isSelected = controller.selectedProfessionalId.value == professional.id;
  //
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 12),
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: isSelected ? AppColours.appColor.withOpacity(0.1) : AppColours.white,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(
  //         color: isSelected ? AppColours.appColor : Colors.grey[300]!,
  //         width: isSelected ? 2 : 1,
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 8,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: GestureDetector(
  //       onTap: () => controller.selectProfessional(professional.id),
  //       child: Row(
  //         children: [
  //           // Professional image/icon
  //           Container(
  //             width: 50,
  //             height: 50,
  //             decoration: BoxDecoration(
  //               color: professional.isAutoAssign ? AppColours.appColor : Colors.grey[200],
  //               shape: BoxShape.circle,
  //             ),
  //             child: professional.isAutoAssign
  //                 ? const Center(
  //                     child: Text(
  //                       'justlife',
  //                       style: TextStyle(
  //                         color: AppColours.white,
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.bold,
  //                         fontFamily: AppFonts.fontFamily,
  //                       ),
  //                     ),
  //                   )
  //                 : ClipOval(
  //                     child: Image.asset(
  //                       professional.image,
  //                       fit: BoxFit.cover,
  //                       errorBuilder: (context, error, stackTrace) {
  //                         return Container(
  //                           color: Colors.grey[300],
  //                           child: const Icon(
  //                             Icons.person,
  //                             color: AppColours.appColor,
  //                             size: 24,
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   ),
  //           ),
  //
  //           const SizedBox(width: 16),
  //
  //           // Professional details
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   professional.name,
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w600,
  //                     color: isSelected ? AppColours.appColor : AppColours.black,
  //                     fontFamily: AppFonts.fontFamily,
  //                   ),
  //                 ),
  //
  //                 if (professional.isAutoAssign) ...[
  //                   const Text(
  //                     'Auto-assign',
  //                     style: TextStyle(
  //                       fontSize: 14,
  //                       color: AppColours.black,
  //                       fontFamily: AppFonts.fontFamily,
  //                     ),
  //                   ),
  //                 ] else ...[
  //                   Row(
  //                     children: [
  //                       const Icon(
  //                         Icons.star,
  //                         color: Colors.amber,
  //                         size: 16,
  //                       ),
  //                       const SizedBox(width: 4),
  //                       Text(
  //                         professional.rating.toString(),
  //                         style: const TextStyle(
  //                           fontSize: 14,
  //                           color: AppColours.black,
  //                           fontFamily: AppFonts.fontFamily,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //
  //                 const SizedBox(height: 4),
  //
  //                 Text(
  //                   professional.description,
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     color: Colors.grey[600],
  //                     fontFamily: AppFonts.fontFamily,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildDateSection(BookServiceStep3ScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'When would you like your service?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),

        const SizedBox(height: 16),

        // Day names row
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
              onTap: () => controller.selectDate(index),
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
      ],
    );
  }

  Widget _buildTimeSection(BookServiceStep3ScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'What time would you like us to start?',
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
                'See all',
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

  Widget _buildCancellationPolicy() {
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

          Expanded(
            child: Text(
              'Enjoy free cancellation up to 6 hours before your booking start time.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              // TODO: Show cancellation details
            },
            child: const Text(
              'Details',
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
    BookServiceStep3ScreenController controller,
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
                'Any specific instructions?',
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
    BookServiceStep3ScreenController controller,
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
                  'Total',
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
                  AppRoutes.bookServiceStep4,
                  arguments: controller.appBarTitle,
                );
              },
              title: "Next",
            ),
          ),
        ],
      ),
    );
  }
}
