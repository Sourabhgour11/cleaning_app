import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookingDetailsController extends GetxController{
  
  var bookingData = <String, String>{}.obs;
  var isPast;

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data - this would typically come from arguments or API
    _initializeBookingData();
    final args = Get.arguments as Map<String, dynamic>;
    isPast = args['isPast'];
  }

  Widget buildFeedbackDialog(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();
    double rating = 0.0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Rate John Smith",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Share your experience with this professional",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 16),

                // ⭐ Rating Bar
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  itemSize: 36,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // 💬 Feedback Input
                TextField(
                  controller: feedbackController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Write your feedback here...",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (rating == 0) {
                        Get.snackbar("Oops!", "Please select a rating before submitting");
                        return;
                      }
                      Get.back();
                      Get.snackbar("Thank you!", "Your feedback has been submitted",
                          backgroundColor: AppColours.appColor);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Submit", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
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