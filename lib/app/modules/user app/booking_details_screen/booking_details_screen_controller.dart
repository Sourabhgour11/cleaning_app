import 'package:cleaning_app/app/utils/app_export.dart';

class BookingDetailsController extends GetxController{
  
  var bookingData = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data - this would typically come from arguments or API
    _initializeBookingData();
  }

  void _initializeBookingData() {
    // Sample booking data - in real app, this would come from Get.arguments or API call
    bookingData.value = {
      'service': 'Home Cleaning',
      'status': 'Confirmed',
      'date': '12 Oct 2025',
      'time': '10:00 AM',
      'bookingId': 'BK123456789',
      'address': '123 Main Street, City, State 12345',
      'duration': '2 hours',
      'frequency': 'One-time',
      'instructions': 'Please clean all rooms thoroughly',
      'providerName': 'John Smith',
      'rating': '4.8',
      'reviews': '120',
      'basePrice': '50.00',
      'additionalPrice': '15.00',
      'serviceFee': '5.00',
      'totalPrice': '70.00',
    };
  }

  // Method to update booking data from arguments
  void updateBookingData(Map<String, dynamic> data) {
    bookingData.value = Map<String, String>.from(data);
  }

  // Method to handle reschedule booking
  void rescheduleBooking() {
    // Implement reschedule logic
    Get.snackbar('Reschedule', 'Redirecting to reschedule page...');
  }

  // Method to contact service provider
  void contactProvider() {
    // Implement contact logic
    Get.snackbar('Contact', 'Opening contact options...');
  }

  // Method to cancel booking
  void cancelBooking() {
    // Implement cancel logic
    Get.snackbar('Cancel', 'Processing cancellation...');
  }
}