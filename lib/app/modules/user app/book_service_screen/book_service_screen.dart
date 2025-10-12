import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'book_service_screen_controller.dart';

class BookServiceScreen extends StatelessWidget {
  const BookServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookServiceScreenController controller = Get.put(BookServiceScreenController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppStyle.appBarStyle(controller.appBarTitle.value),
      body: Column(
        children: [
          // Header Section
          // _buildHeader(controller),
          
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Exclusive Offer Section
                  _buildExclusiveOffer(controller),
                  
                  const SizedBox(height: 24),
                  
                  // Service Duration Section
                  _buildServiceDuration(controller),
                  
                  const SizedBox(height: 24),
                  
                  // Professionals Count Section
                  _buildProfessionalsCount(controller),
                  
                  const SizedBox(height: 24),
                  
                  // Cleaning Materials Section
                  _buildCleaningMaterials(controller),
                  
                  const SizedBox(height: 24),
                  
                  // Specific Instructions Section
                  _buildSpecificInstructions(controller),
                  
                  const SizedBox(height: 100), // Bottom padding for footer
                ],
              ),
            ),
          ),
          
          // Footer with Total and Next Button
          _buildFooter(controller),
        ],
      ),
    );
  }

  Widget _buildHeader(BookServiceScreenController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
            'Step ${controller.currentStep.value} of ${controller.totalSteps.value}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: AppFonts.fontFamily,
            ),
          )),
          const SizedBox(height: 8),
          Obx(() => Text(
            controller.serviceTitle.value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: AppFonts.fontFamily,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildExclusiveOffer(BookServiceScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Exclusive offer for you!',
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
                  Obx(() => Text(
                    controller.offerAmount.value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  )),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                    'Code: ${controller.offerCode.value}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: AppFonts.fontFamily,
                    ),
                  )),
                ],
              ),
              const Spacer(),
              Obx(() => ElevatedButton(
                onPressed: controller.applyOffer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isOfferActive ? Colors.green : AppColours.appColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  controller.offerDisplayText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceDuration(BookServiceScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: const Text(
                'How many hours do you need your professional to stay?',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
        Obx(() => SingleChildScrollView(
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
                      color: isSelected ? AppColours.appColor : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? AppColours.appColor : Colors.grey[300]!,
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
        )),
      ],
    );
  }

  Widget _buildProfessionalsCount(BookServiceScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How many professionals do you need?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
        const SizedBox(height: 16),
        Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: controller.availableProfessionals.map((count) {
              final isSelected = controller.selectedProfessionals.value == count;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => controller.selectProfessionals(count),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColours.appColor : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? AppColours.appColor : Colors.grey[300]!,
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
        )),
      ],
    );
  }

  Widget _buildCleaningMaterials(BookServiceScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Need cleaning materials?',
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
            Text(
              'Powered by',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontFamily: AppFonts.fontFamily,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.eco, color: Colors.green[600], size: 12),
                  const SizedBox(width: 4),
                  Text(
                    'Jif',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[600],
                      fontFamily: AppFonts.fontFamily,
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
            Expanded(
              child: Obx(() => GestureDetector(
                onTap: () => controller.toggleCleaningMaterials(),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: !controller.needsCleaningMaterials.value ? AppColours.appColor : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'No, I have them',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: !controller.needsCleaningMaterials.value ? Colors.white : Colors.grey[600],
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ),
                ),
              )),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Obx(() => GestureDetector(
                onTap: () => controller.toggleCleaningMaterials(),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: controller.needsCleaningMaterials.value ? AppColours.appColor : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Yes, please',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: controller.needsCleaningMaterials.value ? Colors.white : Colors.grey[600],
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ),
                ),
              )),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecificInstructions(BookServiceScreenController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => Text(
              controller.hasInstructions.value 
                  ? controller.specificInstructions.value
                  : 'Any specific instructions?',
              style: TextStyle(
                fontSize: 14,
                color: controller.hasInstructions.value ? Colors.black : Colors.grey[600],
                fontFamily: AppFonts.fontFamily,
              ),
            )),
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

  Widget _buildFooter(BookServiceScreenController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                    Obx(() => Text(
                      controller.getFormattedPrice(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    )),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Obx(() => ElevatedButton(
              onPressed: controller.nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                controller.currentStep.value < controller.totalSteps.value ? 'Next' : 'Complete',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
