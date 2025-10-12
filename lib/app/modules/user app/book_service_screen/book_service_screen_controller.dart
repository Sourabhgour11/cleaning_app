import 'package:cleaning_app/app/utils/app_export.dart';

class BookServiceScreenController extends GetxController {

var appBarTitle = "".obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   if (Get.arguments != null) {
  //     appBarTitle.value = Get.arguments.toString();
  //   }
  // }

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
}