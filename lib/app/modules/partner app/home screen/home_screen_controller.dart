import 'package:get/get.dart';

class PartnerHomeScreenController extends GetxController {
  var userName = 'Sourabh'.obs;
  var location = '1302, Nehru place, Jumeirah Beach Residence'.obs;
  var currentIndex = 0.obs;
  var selectedTabIndex = 0.obs;
  var scrollOffset = 0.0.obs;
  var selectedJobFilter = 0.obs; // 0: Upcoming, 1: Pending, 2: Completed

  // Partner-specific properties

  var totalEarnings = 2500.obs;
  var completedJobs = 12.obs;
  var rating = 4.8.obs;
  var upcomingBookings = 3.obs;

  // Job filter options
  var jobFilterOptions = ['Upcoming', 'Pending', 'Completed'].obs;

  // Sample job data for different states
  var upcomingJobsList = [
    {
      'title': 'Office Deep Clean',
      'location': 'Tech Park, Sector 5',
      'amount': 1200,
      'date': 'Today, 2:00 PM',
      'status': 'upcoming',
      'client': 'ABC Corporation',
    },
    {
      'title': 'House Cleaning',
      'location': 'Green Valley, Phase 2',
      'amount': 800,
      'date': 'Tomorrow, 10:00 AM',
      'status': 'upcoming',
      'client': 'John Smith',
    },
    {
      'title': 'Carpet Cleaning',
      'location': 'Downtown Plaza',
      'amount': 600,
      'date': 'Dec 20, 3:00 PM',
      'status': 'upcoming',
      'client': 'Sarah Johnson',
    },
  ].obs;

  var pendingJobsList = [
    {
      'title': 'Window Cleaning',
      'location': 'High Rise Building, Floor 15',
      'amount': 900,
      'date': 'Waiting for confirmation',
      'status': 'pending',
      'client': 'Property Manager',
    },
    {
      'title': 'Post-Construction Clean',
      'location': 'New Development Site',
      'amount': 1500,
      'date': 'Awaiting materials',
      'status': 'pending',
      'client': 'Construction Co.',
    },
  ].obs;

  var completedJobsList = [
    {
      'title': 'House Cleaning',
      'location': '123 Main Street, Mumbai',
      'amount': 500,
      'date': '2 hours ago',
      'status': 'completed',
      'client': 'Mrs. Sharma',
    },
    {
      'title': 'Office Cleaning',
      'location': '456 Business Park, Mumbai',
      'amount': 800,
      'date': '1 day ago',
      'status': 'completed',
      'client': 'Tech Solutions Inc.',
    },
    {
      'title': 'Deep Cleaning',
      'location': '789 Residential Complex, Mumbai',
      'amount': 1200,
      'date': '2 days ago',
      'status': 'completed',
      'client': 'Mr. Patel',
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

  // Get current jobs based on selected filter
  List<Map<String, dynamic>> get currentJobsList {
    switch (selectedJobFilter.value) {
      case 0:
        return upcomingJobsList;
      case 1:
        return pendingJobsList;
      case 2:
        return completedJobsList;
      default:
        return upcomingJobsList;
    }
  }

  // Method to change job filter
  void changeJobFilter(int index) {
    selectedJobFilter.value = index;
  }
}
