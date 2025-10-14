import 'package:cleaning_app/app/utils/app_export.dart';

class UserBookingScreenController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    // Example data
    upcomingBookings.addAll([
      {
        'service': 'Home Cleaning',
        'date': '12 Oct 2025',
        'time': '10:00 AM',
      },
      {
        'service': 'AC Repair',
        'date': '15 Oct 2025',
        'time': '02:00 PM',
      },
    ]);

    pastBookings.addAll([
      {
        'service': 'Bathroom Cleaning',
        'date': '01 Oct 2025',
        'time': '11:00 AM',
      },
    ]);
  }

  var upcomingBookings = <Map<String, String>>[].obs;
  var pastBookings = <Map<String, String>>[].obs;


}