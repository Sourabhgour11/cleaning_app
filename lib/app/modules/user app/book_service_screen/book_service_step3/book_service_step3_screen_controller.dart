import 'package:cleaning_app/app/utils/app_export.dart';

class Professional {
  final String id;
  final String name;
  final String image;
  final double rating;
  final String description;
  final bool isAutoAssign;

  Professional({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.description,
    this.isAutoAssign = false,
  });
}

class TimeSlot {
  final String id;
  final String timeRange;
  final bool isAvailable;

  TimeSlot({
    required this.id,
    required this.timeRange,
    this.isAvailable = true,
  });
}

class BookServiceStep3ScreenController extends GetxController {

  // Selected professional
  final RxString selectedProfessionalId = 'auto'.obs;
  
  // Selected date
  final RxString selectedDate = ''.obs;
  
  // Selected time slot
  final RxString selectedTimeSlotId = ''.obs;
  
  // Base service price (this would come from previous step)
  final RxDouble baseServicePrice = 209.0.obs;

  final TextEditingController instructionsController = TextEditingController();

  var appBarTitle = "".obs;

  @override
  void onInit() {
    super.onInit();
    appBarTitle.value = Get.arguments.toString();
    _initializeDates();
  }

  // Professionals data
  // final List<Professional> professionals = [
  //   Professional(
  //     id: 'auto',
  //     name: 'justlife',
  //     image: '',
  //     rating: 0.0,
  //     description: "We'll assign the best professional.",
  //     isAutoAssign: true,
  //   ),
  //   Professional(
  //     id: 'honeey',
  //     name: 'Honeey Lyn',
  //     image: 'lib/assets/images/woman_salon.webp',
  //     rating: 5.0,
  //     description: 'Recommended in your area.',
  //   ),
  //   Professional(
  //     id: 'mariel',
  //     name: 'Mariel',
  //     image: 'lib/assets/images/mans_salon.jpg',
  //     rating: 4.9,
  //     description: 'Recommended in your area.',
  //   ),
  // ];

  // Available time slots
  final List<TimeSlot> timeSlots = [
    TimeSlot(id: '1', timeRange: '11:30-12:00'),
    TimeSlot(id: '2', timeRange: '12:00-12:30'),
    TimeSlot(id: '3', timeRange: '12:30-13:00'),
    TimeSlot(id: '4', timeRange: '13:00-13:30'),
    TimeSlot(id: '5', timeRange: '13:30-14:00'),
    TimeSlot(id: '6', timeRange: '14:00-14:30'),
    TimeSlot(id: '7', timeRange: '14:30-15:00'),
    TimeSlot(id: '8', timeRange: '15:00-15:30'),
  ];

  // Date-related variables
  final RxList<Map<String, dynamic>> availableDates = <Map<String, dynamic>>[].obs;
  final RxInt selectedDateIndex = 0.obs;

  void _initializeDates() {
    final now = DateTime.now();
    final List<Map<String, dynamic>> dates = [];
    
    for (int i = 0; i < 7; i++) {
      final date = now.add(Duration(days: i));
      final dayNames = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
      
      dates.add({
        'dayName': dayNames[date.weekday - 1],
        'date': date.day,
        'fullDate': date,
        'isSelected': i == 0,
      });
    }
    
    availableDates.value = dates;
    if (dates.isNotEmpty) {
      selectedDate.value = '${dates[0]['date']}';
    }
  }

  // // Select professional
  // void selectProfessional(String professionalId) {
  //   selectedProfessionalId.value = professionalId;
  //   update();
  // }

  // Select date
  void selectDate(int index) {
    selectedDateIndex.value = index;
    selectedDate.value = '${availableDates[index]['date']}';
    update();
  }

  // Select time slot
  void selectTimeSlot(String timeSlotId) {
    selectedTimeSlotId.value = timeSlotId;
    update();
  }

  // // Get selected professional
  // Professional get selectedProfessional {
  //   return professionals.firstWhere(
  //     (prof) => prof.id == selectedProfessionalId.value,
  //     orElse: () => professionals.first,
  //   );
  // }

  // Get selected time slot
  TimeSlot get selectedTimeSlot {
    return timeSlots.firstWhere(
      (slot) => slot.id == selectedTimeSlotId.value,
      orElse: () => timeSlots.first,
    );
  }

  // Navigate to next step
  void goToNextStep() {
    // TODO: Navigate to next step with selected data
    Get.snackbar('Success', 'Date & Time selected successfully!');
  }

  RxBool isEdit = false.obs;

  void showAdditionalInstructionsBottomSheet(BuildContext context) {

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            // To make sure keyboard doesn’t cover the textfield
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Additional Instructions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColours.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),

              const SizedBox(height: 16),

              // Text field
              TextFormField(
                controller: instructionsController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Type your instructions here...',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: AppFonts.fontFamily,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColours.appColor),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Done Button
              SizedBox(
                width: double.infinity,
                height: AppStyle.heightPercent(context, 6),
                child: AppButton(onPressed: (){
                  update();
                  Get.back();
                }, title: "Done")
              ),
            ],
          ),
        );
      },
    );
  }


}