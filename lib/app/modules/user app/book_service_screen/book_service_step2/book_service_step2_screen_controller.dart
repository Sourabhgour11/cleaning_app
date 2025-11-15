import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:intl/intl.dart';

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

class BookServiceStep2ScreenController extends GetxController {

  final RxString selectedProfessionalId = 'auto'.obs;
  final RxString selectedTimeSlotId = ''.obs;
  final RxDouble baseServicePrice = 209.0.obs;
  final TextEditingController instructionsController = TextEditingController();
  var appBarTitle = "".obs;

  @override
  void onInit() {
    super.onInit();
    appBarTitle.value = Get.arguments.toString();
    generate30Days();
  }

  // RxList<DateTime> weekDates = <DateTime>[].obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // The 30 days to display in the calendar
  List<DateTime> weekDates = List.generate(
    30,
        (index) => DateTime.now().add(Duration(days: index)),
  );
  /// Store final selected date in a String
  RxString selectedDateString = "".obs;

  // Keep track of selected weekdays from dialog (1 = Monday, ..., 7 = Sunday)
  RxSet<int> selectedWeekdays = <int>{}.obs;

  void generate30Days() {
    DateTime today = DateTime.now();
    weekDates.clear();

    for (int i = 0; i < 30; i++) {
      weekDates.add(today.add(Duration(days: i)));

    }
    update();
  }

  /// Select a date & store in variable
  void selectDate(DateTime date) {
    selectedDate.value = date;

    // Save formatted date
    selectedDateString.value = DateFormat("yyyy-MM-dd").format(date);
    update();

    print("Selected Date: ${selectedDateString.value}");
  }

  // This is called when user selects weekdays from dialog
  void updateSelectedWeekdays(List<int> weekdays) {
    selectedWeekdays.value = weekdays.toSet();
    update();
  }

  /// Get formatted date (if needed externally)
  String get formattedSelectedDate {
    if (selectedDate.value == null) return "";
    return DateFormat("yyyy-MM-dd").format(selectedDate.value!);
  }

  final List<String> weekDays = [
    "Sunday", "Monday", "Tuesday", "Wednesday",
    "Thursday", "Friday", "Saturday"
  ];

  // Selected days
  RxList<String> selectedDays = <String>[].obs;

  // Toggle checkbox
  void toggleDay(String day, bool value) {
    if (value) {
      selectedDays.add(day);
    } else {
      selectedDays.remove(day);
    }
  }

  void showWeekdayDialog(BookServiceStep2ScreenController controller) {
    List<String> weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    List<bool> selected = List.generate(7, (index) => false);

    Get.defaultDialog(
      title: "Select Weekdays",
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: List.generate(7, (index) {
              return CheckboxListTile(
                title: Text(weekdays[index]),
                value: selected[index],
                onChanged: (val) {
                  setState(() {
                    selected[index] = val!;
                  });
                },
              );
            }),
          );
        },
      ),
      textConfirm: "OK",
      onConfirm: () {
        List<int> pickedWeekdays = [];
        for (int i = 0; i < 7; i++) {
          if (selected[i]) pickedWeekdays.add(i + 1); // Monday = 1
        }
        controller.updateSelectedWeekdays(pickedWeekdays);
        Get.back();
      },
    );
  }




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

  // Select time slot
  void selectTimeSlot(String timeSlotId) {
    selectedTimeSlotId.value = timeSlotId;
    update();
  }


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

  Widget weekCalendar(BookServiceStep2ScreenController controller) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Date",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.weekDates.length,
              itemBuilder: (context, index) {
                DateTime date = controller.weekDates[index];

                bool isSelected =
                    controller.selectedDate.value?.day == date.day &&
                        controller.selectedDate.value?.month == date.month &&
                        controller.selectedDate.value?.year == date.year;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      // DAY NAME
                      Text(
                        DateFormat("E").format(date).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 5),

                      GestureDetector(
                        onTap: () => controller.selectDate(date),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.teal : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.teal : Colors.black26,
                              width: 1.6,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      );
    });
  }

}