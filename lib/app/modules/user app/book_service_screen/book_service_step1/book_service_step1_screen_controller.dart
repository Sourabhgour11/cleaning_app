import 'package:cleaning_app/app/utils/app_export.dart';

class BookServiceStep1ScreenController extends GetxController {
  var appBarTitle = "".obs;

  // Step tracking
  final RxInt currentStep = 1.obs;
  final RxInt totalSteps = 4.obs;

  // Service details
  final RxString serviceTitle = 'Home Cleaning'.obs;
  final RxBool isFavorited = false.obs;

  // Exclusive offer
  final RxString offerCode = '50OFFCLEAN'.obs;
  final RxString offerAmount = '50 AED Off'.obs;
  final RxBool isOfferApplied = false.obs;

  // Service duration (hours)
  final RxInt selectedHours = 2.obs;
  final RxList<int> availableHours = [1, 2, 3, 4, 5, 6, 7].obs;

  // Professionals count
  final RxInt selectedProfessionals = 1.obs;
  final RxList<int> availableProfessionals = [1, 2, 3, 4].obs;

  // Cleaning materials
  final RxBool needsCleaningMaterials = false.obs;
  final RxString materialsProvider = 'Jif'.obs;

  // Specific instructions
  final RxString specificInstructions = ''.obs;
  final RxBool hasInstructions = false.obs;

  // Pricing
  final RxDouble basePrice = 39.0.obs;
  final RxDouble totalPrice = 78.0.obs;
  final RxString currency = 'AED'.obs;

  // Text editing controller for instructions
  late TextEditingController instructionsController;

  @override
  void onInit() {
    super.onInit();
    appBarTitle.value = Get.arguments.toString();
    instructionsController = TextEditingController();
    _calculateTotalPrice();
  }

  @override
  void onClose() {
    instructionsController.dispose();
    super.onClose();
  }

  // Toggle favorite status
  void toggleFavorite() {
    isFavorited.value = !isFavorited.value;
  }

  // Apply offer code
  void applyOffer() {
    isOfferApplied.value = !isOfferApplied.value;
    _calculateTotalPrice();
  }

  // Select service duration
  void selectHours(int hours) {
    selectedHours.value = hours;
    _calculateTotalPrice();
  }

  // Select number of professionals
  void selectProfessionals(int count) {
    selectedProfessionals.value = count;
    _calculateTotalPrice();
  }

  // Toggle cleaning materials
  void toggleCleaningMaterials() {
    needsCleaningMaterials.value = !needsCleaningMaterials.value;
    _calculateTotalPrice();
  }

  // Add specific instructions
  void addInstructions() {
    Get.dialog(
      AlertDialog(
        title: const Text('Add Instructions'),
        content: TextField(
          controller: instructionsController,
          decoration: const InputDecoration(
            hintText: 'Enter your specific instructions...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              instructionsController.clear();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              specificInstructions.value = instructionsController.text;
              hasInstructions.value = specificInstructions.value.isNotEmpty;
              Get.back();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // Calculate total price
  void _calculateTotalPrice() {
    double price = basePrice.value;

    // Multiply by selected hours
    price *= selectedHours.value;

    // Multiply by number of professionals
    price *= selectedProfessionals.value;

    // Add cleaning materials cost if needed
    if (needsCleaningMaterials.value) {
      price += 20.0; // Additional cost for materials
    }

    // Apply discount if offer is applied
    if (isOfferApplied.value) {
      price -= 50.0;
      if (price < 0) price = 0; // Ensure price doesn't go negative
    }

    totalPrice.value = price;
  }

  // Navigate to next step
  void nextStep() {
    if (currentStep.value < totalSteps.value) {
      currentStep.value++;
    } else {
      // Complete booking
      _completeBooking();
    }
  }

  // Navigate to previous step
  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  // Complete booking process
  void _completeBooking() {
    Get.snackbar(
      'Booking Confirmed!',
      'Your cleaning service has been booked successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
    // Here you would typically navigate to confirmation screen or back to home
    Get.back();
  }

  // Get formatted price
  String getFormattedPrice() {
    return '${currency.value} ${totalPrice.value.toStringAsFixed(0)}.00';
  }

  // Check if offer is applied
  bool get isOfferActive => isOfferApplied.value;

  // Get offer display text
  String get offerDisplayText => isOfferApplied.value ? 'Applied' : 'Apply';

  void showBookingSummaryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.55,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        const SizedBox(height: 10),

                        // Drag handle
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Summary Title
                        const Text(
                          "Summary",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Service Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Single - 60 mins",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text(
                                    "AED 249",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "AED 350",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Payment Summary
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Payment Summary",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Subtotal",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "AED 249.00",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Service Fee",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(
                                        Icons.info_outline,
                                        size: 16,
                                        color: Colors.grey[500],
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    "AED 9.00",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Total (inc. VAT)",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "AED 258.00",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),

                  // Bottom Fixed Bar
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "AED 258.00",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppStyle.heightPercent(context, 5),
                            width: AppStyle.widthPercent(context, 30),
                            child: AppButton(
                              onPressed: () {
                                Get.toNamed(
                                  AppRoutes.bookServiceStep3,
                                  arguments: appBarTitle,
                                );
                              },
                              title: "Next",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
