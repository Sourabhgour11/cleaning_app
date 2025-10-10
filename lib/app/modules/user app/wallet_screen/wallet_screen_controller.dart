import 'package:cleaning_app/app/utils/app_export.dart';

class WalletScreenController extends GetxController{
  // Wallet balance
  final RxDouble walletBalance = 0.0.obs;
  final RxDouble totalEarnings = 0.0.obs;
  final RxDouble pendingAmount = 0.0.obs;
  
  // Transaction history
  final RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[].obs;
  
  // Payment methods
  final RxList<Map<String, dynamic>> paymentMethods = <Map<String, dynamic>>[].obs;
  
  // Quick actions
  final RxList<Map<String, dynamic>> quickActions = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeWalletData();
  }

  void _initializeWalletData() {
    // Initialize wallet balance
    walletBalance.value = 1250.50;
    totalEarnings.value = 5670.25;
    pendingAmount.value = 320.75;
    
    // Initialize transactions
    transactions.value = [
      {
        'id': '1',
        'type': 'earning',
        'title': 'Home Cleaning Service',
        'description': 'Payment received for cleaning service',
        'amount': 150.00,
        'date': '2024-01-15',
        'time': '14:30',
        'status': 'completed',
        'icon': Icons.cleaning_services,
      },
      {
        'id': '2',
        'type': 'withdrawal',
        'title': 'Bank Transfer',
        'description': 'Withdrawal to bank account',
        'amount': -500.00,
        'date': '2024-01-14',
        'time': '09:15',
        'status': 'completed',
        'icon': Icons.account_balance,
      },
      {
        'id': '3',
        'type': 'earning',
        'title': 'Office Cleaning',
        'description': 'Payment received for office cleaning',
        'amount': 200.00,
        'date': '2024-01-13',
        'time': '16:45',
        'status': 'completed',
        'icon': Icons.business,
      },
      {
        'id': '4',
        'type': 'earning',
        'title': 'Deep Cleaning Service',
        'description': 'Payment received for deep cleaning',
        'amount': 300.00,
        'date': '2024-01-12',
        'time': '11:20',
        'status': 'pending',
        'icon': Icons.cleaning_services,
      },
      {
        'id': '5',
        'type': 'bonus',
        'title': 'Referral Bonus',
        'description': 'Bonus for referring new customer',
        'amount': 50.00,
        'date': '2024-01-11',
        'time': '10:00',
        'status': 'completed',
        'icon': Icons.card_giftcard,
      },
    ];
    
    // Initialize payment methods
    paymentMethods.value = [
      {
        'id': '1',
        'type': 'bank',
        'name': 'Primary Bank Account',
        'accountNumber': '****1234',
        'bankName': 'Chase Bank',
        'isDefault': true,
        'icon': Icons.account_balance,
      },
      {
        'id': '2',
        'type': 'card',
        'name': 'Visa Card',
        'accountNumber': '****5678',
        'bankName': 'Chase Bank',
        'isDefault': false,
        'icon': Icons.credit_card,
      },
    ];
    
    // Initialize quick actions
    quickActions.value = [
      {
        'title': 'Withdraw Money',
        'subtitle': 'Transfer to bank account',
        'icon': Icons.account_balance_wallet,
        'color': AppColours.appColor,
      },
      {
        'title': 'Add Payment Method',
        'subtitle': 'Link new bank account',
        'icon': Icons.add_card,
        'color': AppColours.green,
      },
      {
        'title': 'Transaction History',
        'subtitle': 'View all transactions',
        'icon': Icons.history,
        'color': AppColours.orange,
      },
      // {
      //   'title': 'Earnings Report',
      //   'subtitle': 'View detailed reports',
      //   'icon': Icons.analytics,
      //   'color': AppColours.blue,
      // },
    ];
  }

  void onWithdrawMoney() {
    Get.snackbar(
      'Withdraw Money',
      'Withdrawal feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onAddPaymentMethod() {
    Get.snackbar(
      'Add Payment Method',
      'Add payment method feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onViewTransactionHistory() {
    Get.snackbar(
      'Transaction History',
      'Viewing all transactions...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onViewEarningsReport() {
    Get.snackbar(
      'Earnings Report',
      'Generating earnings report...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  String getTransactionTypeText(String type) {
    switch (type) {
      case 'earning':
        return 'Earning';
      case 'withdrawal':
        return 'Withdrawal';
      case 'bonus':
        return 'Bonus';
      default:
        return 'Transaction';
    }
  }

  Color getTransactionTypeColor(String type) {
    switch (type) {
      case 'earning':
        return AppColours.green;
      case 'withdrawal':
        return AppColours.red;
      case 'bonus':
        return AppColours.orange;
      default:
        return AppColours.grey;
    }
  }
}