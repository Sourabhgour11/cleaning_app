import 'package:get/get.dart';

class CleanerHomeScreenController extends GetxController {
  var userName = 'Sourabh'.obs;
  var location = '1302, Nehru place, Jumeirah Beach Residence'.obs;
  var currentIndex = 0.obs;
  var selectedTabIndex = 0.obs;
  var scrollOffset = 0.0.obs;

  // Cleaner-specific properties

  var totalEarnings = 2500.obs;
  var completedJobs = 12.obs;
  var rating = 4.8.obs;
  var upcomingBookings = 3.obs;

  var completedJobsList = [
    {
      'title': 'House Cleaning',
      'location': '123 Main Street, Mumbai',
      'amount': 500,
      'time': '2 hours ago',
    },
    {
      'title': 'Office Cleaning',
      'location': '456 Business Park, Mumbai',
      'amount': 800,
      'time': '1 day ago',
    },
    {
      'title': 'Deep Cleaning',
      'location': '789 Residential Complex, Mumbai',
      'amount': 1200,
      'time': '2 days ago',
    },
  ].obs;

  var images = [
    "lib/assets/images/banner1.jpg",
    "lib/assets/images/banner2.webp",
    "lib/assets/images/banner3.jpg",
    "lib/assets/images/banner4.webp",
    "lib/assets/images/banner5.jpg",
    "lib/assets/images/banner6.webp",
  ];
}
