import 'package:get/get.dart';

class BookingController extends GetxController {
  var isLoading = false.obs;
  var selectedTab = 0.obs; // 0: Upcoming, 1: In Progress, 2: Completed
  var searchQuery = ''.obs;

  // Sample booking data
  var upcomingBookings = <Map<String, dynamic>>[
    {
      'id': '1',
      'customerName': 'Sarah Johnson',
      'customerImage': 'https://via.placeholder.com/50',
      'serviceType': 'Deep Cleaning',
      'address': '123 Main St, Downtown',
      'date': '2024-01-15',
      'time': '10:00 AM',
      'duration': '3 hours',
      'price': '₹1,500',
      'status': 'upcoming',
      'notes': 'Please bring extra cleaning supplies',
      'phone': '+91 98765 43210',
    },
    {
      'id': '2',
      'customerName': 'Mike Chen',
      'customerImage': 'https://via.placeholder.com/50',
      'serviceType': 'Regular Cleaning',
      'address': '456 Oak Ave, Suburb',
      'date': '2024-01-16',
      'time': '2:00 PM',
      'duration': '2 hours',
      'price': '₹800',
      'status': 'upcoming',
      'notes': 'Pet-friendly cleaning required',
      'phone': '+91 98765 43211',
    },
    {
      'id': '2',
      'customerName': 'Sarah Johnson',
      'customerImage': 'https://via.placeholder.com/50',
      'serviceType': 'Deep Cleaning',
      'address': '123 Main St, Downtown',
      'date': '2024-01-15',
      'time': '10:00 AM',
      'duration': '3 hours',
      'price': '₹1,500',
      'status': 'upcoming',
      'notes': 'Please bring extra cleaning supplies',
      'phone': '+91 98765 43210',
    },
  ].obs;

  var inProgressBookings = <Map<String, dynamic>>[
    {
      'id': '3',
      'customerName': 'Emma Wilson',
      'customerImage': 'https://via.placeholder.com/50',
      'serviceType': 'Office Cleaning',
      'address': '789 Business Park',
      'date': '2024-01-14',
      'time': '9:00 AM',
      'duration': '4 hours',
      'price': '₹2,000',
      'status': 'in_progress',
      'notes': 'Focus on conference rooms',
      'phone': '+91 98765 43212',
    },
  ].obs;

  var completedBookings = <Map<String, dynamic>>[
    {
      'id': '4',
      'customerName': 'David Brown',
      'customerImage': 'https://via.placeholder.com/50',
      'serviceType': 'Post-Construction Cleaning',
      'address': '321 New Building',
      'date': '2024-01-13',
      'time': '8:00 AM',
      'duration': '6 hours',
      'price': '₹3,500',
      'status': 'completed',
      'notes': 'Excellent work!',
      'phone': '+91 98765 43213',
      'rating': 5,
    },
    {
      'id': '5',
      'customerName': 'Lisa Garcia',
      'customerImage': 'https://via.placeholder.com/50',
      'serviceType': 'Move-in Cleaning',
      'address': '654 Residential Complex',
      'date': '2024-01-12',
      'time': '11:00 AM',
      'duration': '3 hours',
      'price': '₹1,200',
      'status': 'completed',
      'notes': 'Very satisfied',
      'phone': '+91 98765 43214',
      'rating': 4,
    },
  ].obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void acceptBooking(String bookingId) {
    // Move booking from upcoming to in_progress
    var booking = upcomingBookings.firstWhere((b) => b['id'] == bookingId);
    booking['status'] = 'in_progress';
    upcomingBookings.removeWhere((b) => b['id'] == bookingId);
    inProgressBookings.add(booking);
    Get.snackbar('Success', 'Booking accepted successfully!');
  }

  void rejectBooking(String bookingId) {
    upcomingBookings.removeWhere((b) => b['id'] == bookingId);
    Get.snackbar('Info', 'Booking rejected');
  }

  void completeBooking(String bookingId) {
    // Move booking from in_progress to completed
    var booking = inProgressBookings.firstWhere((b) => b['id'] == bookingId);
    booking['status'] = 'completed';
    inProgressBookings.removeWhere((b) => b['id'] == bookingId);
    completedBookings.add(booking);
    Get.snackbar('Success', 'Booking completed successfully!');
  }

  void startBooking(String bookingId) {
    var booking = upcomingBookings.firstWhere((b) => b['id'] == bookingId);
    booking['status'] = 'in_progress';
    upcomingBookings.removeWhere((b) => b['id'] == bookingId);
    inProgressBookings.add(booking);
    Get.snackbar('Started', 'Booking started!');
  }

  List<Map<String, dynamic>> get filteredBookings {
    var allBookings = <Map<String, dynamic>>[];

    switch (selectedTab.value) {
      case 0:
        allBookings = upcomingBookings;
        break;
      case 1:
        allBookings = inProgressBookings;
        break;
      case 2:
        allBookings = completedBookings;
        break;
    }

    if (searchQuery.value.isEmpty) {
      return allBookings;
    }

    return allBookings.where((booking) {
      return booking['customerName'].toString().toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          booking['serviceType'].toString().toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          booking['address'].toString().toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          );
    }).toList();
  }
}
