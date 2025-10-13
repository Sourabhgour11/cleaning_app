import 'package:get/get.dart';

class IncentiveScreenController extends GetxController {
  // Observable variables
  var totalEarnings = 0.0.obs;
  var monthlyEarnings = 0.0.obs;
  var weeklyEarnings = 0.0.obs;
  var bonusEarnings = 0.0.obs;

  // Sample data for incentives
  var incentiveCards = <Map<String, dynamic>>[].obs;
  var recentIncentives = <Map<String, dynamic>>[].obs;
  var achievements = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    // Set earnings data
    totalEarnings.value = 2450.50;
    monthlyEarnings.value = 850.00;
    weeklyEarnings.value = 320.00;
    bonusEarnings.value = 180.50;

    // Incentive cards data
    incentiveCards.value = [
      {
        'title': 'Performance Bonus',
        'amount': 150.00,
        'icon': 'trophy',
        'color': 'orange',
        'description': 'Excellent service ratings',
      },
      {
        'title': 'Quick Service',
        'amount': 75.00,
        'icon': 'timer',
        'color': 'blue',
        'description': 'Completed jobs on time',
      },
      {
        'title': 'Customer Favorite',
        'amount': 100.00,
        'icon': 'star',
        'color': 'purple',
        'description': '5-star customer ratings',
      },
      {
        'title': 'Referral Bonus',
        'amount': 50.00,
        'icon': 'people',
        'color': 'green',
        'description': 'New customer referrals',
      },
    ];

    // Recent incentives history
    recentIncentives.value = [
      {
        'title': 'Performance Bonus',
        'amount': 50.00,
        'date': '10/10/2025',
        'status': 'Credited',
      },
      {
        'title': 'Quick Completion',
        'amount': 30.00,
        'date': '08/10/2025',
        'status': 'Credited',
      },
      {
        'title': 'Weekend Bonus',
        'amount': 75.00,
        'date': '06/10/2025',
        'status': 'Credited',
      },
      {
        'title': '5-Star Rating',
        'amount': 25.50,
        'date': '05/10/2025',
        'status': 'Credited',
      },
      {
        'title': 'Early Bird Bonus',
        'amount': 40.00,
        'date': '03/10/2025',
        'status': 'Credited',
      },
    ];

    // Achievements/Progress
    achievements.value = [
      {
        'title': '100 Jobs Milestone',
        'progress': 0.85,
        'current': 85,
        'target': 100,
        'reward': 200.00,
      },
      {
        'title': 'Perfect Week',
        'progress': 0.71,
        'current': 5,
        'target': 7,
        'reward': 100.00,
      },
      {
        'title': 'Customer Champion',
        'progress': 0.60,
        'current': 30,
        'target': 50,
        'reward': 150.00,
      },
    ];
  }

  void refreshData() {
    // Simulate data refresh
    _initializeData();
  }
}
