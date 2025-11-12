import 'dart:convert';
import 'package:cleaning_app/app/data/models/get_wallet_details_model.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:http/http.dart' as http;

class WalletScreenController extends GetxController{
  // Wallet balance
  final RxDouble walletBalance = 0.0.obs;
  RxBool isLoading = false.obs;
  
  // Transaction history
  final RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[].obs;

  final Rx<WalletDetailsModel?> walletDetailsModel = Rx<WalletDetailsModel?>(null);


  @override
  void onInit() {
    super.onInit();
    getWalletDetailsApi();
  }

  Future<void> getWalletDetailsApi() async {
    isLoading.value = true;

    try {
      final userId = AppLocalStorage.getUserId();
      final token = AppLocalStorage.getToken();
      // TODO: Replace with actual wallet API endpoint when available
      // For now, using sample data structure
      final url = Uri.parse(AppUrl.walletDetailsApi("3" ?? ''));

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token ?? ""}',
      };

      final response = await http.get(url, headers: headers);

      print("📡 Wallet API URL: $url");
      print("📩 Status Code: ${response.statusCode}");
      print("📨 Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Wallet data: $data");

        if (data['status'] == true || data['success'] == true) {
          final responseBody = jsonDecode(response.body);
          print("successsss");
          walletDetailsModel.value = WalletDetailsModel.fromJson(responseBody);

          // Update wallet balance and transactions from API response

          // _updateWalletFromApi(walletDetailsModel.value);

        } else {
          // If API fails, use sample data for development
          _loadSampleData();
          Get.snackbar('Info', 'Using sample wallet data. ${data['message'] ?? 'API not configured'}');
        }
      } else {
        // If API fails, use sample data for development
        _loadSampleData();

        Get.snackbar('Info', 'Using sample wallet data. API returned: ${response.statusCode}');
        print("${response.statusCode}STSTS");
      }
    } catch (e) {
      print("Wallet API Error: ${e.toString()}");
      // If API fails, use sample data for development
      _loadSampleData();
      Get.snackbar('Info', 'Using sample wallet data. Error: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void _updateWalletFromApi(WalletDetailsModel? model) {
    if (model == null || model.wallet == null || model.wallet!.isEmpty) {
      walletBalance.value = 0.0;
      transactions.value = [];
      return;
    }

    double runningSum = 0.0;
    int? latestBalanceRaw;
    final List<Map<String, dynamic>> transactionList = [];

    for (var wallet in model.wallet!) {
      // Determine credit/debit from either numeric status or label
      final bool isCredit = wallet.amountStatus == 1 ||
          (wallet.amountStatusLabel?.toLowerCase().contains('credit') ?? false);

      // Choose correct amount field:
      // - Credit: prefer walletAmount, else debitedAmount
      // - Debit: prefer debitedAmount, else walletAmount
      final double creditAmount =
          (wallet.walletAmount ?? wallet.debitedAmount ?? 0).toDouble();
      final double debitAmount =
          (wallet.debitedAmount ?? wallet.walletAmount ?? 0).toDouble();

      final double txnAmount = isCredit ? creditAmount : -debitAmount;
      runningSum += txnAmount;

      // Track the latest balance if backend provides it on every row
      if (wallet.walletAmount != null) {
        latestBalanceRaw = wallet.walletAmount;
      }

      // Parse date and time from createtime
      String date = '';
      String time = '';
      if (wallet.createtime != null) {
        try {
          final dateTime = DateTime.parse(wallet.createtime!);
          date =
              '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
          time =
              '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
        } catch (e) {
          date = wallet.createtime ?? '';
          time = '';
        }
      }

      transactionList.add({
        'id': wallet.walletId?.toString() ?? '',
        'type': isCredit ? 'recharge' : 'service_payment',
        'title': isCredit ? 'Wallet Recharge' : 'Service Payment',
        'description': isCredit
            ? 'Amount added to wallet'
            : 'Payment for service booking #${wallet.bookingId ?? 'N/A'}',
        'amount': txnAmount,
        'date': date,
        'time': time,
        'status': 'completed',
        'icon': isCredit ? Icons.account_balance_wallet : Icons.cleaning_services,
        'bookingId': wallet.bookingId,
      });
    }

    // Sort transactions by date (newest first)
    transactionList.sort((a, b) {
      final dateA = a['date'] as String;
      final dateB = b['date'] as String;
      if (dateA.isEmpty) return 1;
      if (dateB.isEmpty) return -1;
      return dateB.compareTo(dateA);
    });

    // Prefer backend-provided latest wallet balance if available; else sum
    walletBalance.value =
        latestBalanceRaw != null ? latestBalanceRaw!.toDouble() : runningSum;
    transactions.value = transactionList;
  }

  void _loadSampleData() {
    // Sample data for development/testing
    walletBalance.value = 1250.50;
    
    transactions.value = [
      {
        'id': '1',
        'type': 'service_payment',
        'title': 'Home Cleaning Service',
        'description': 'Payment for service booking #1234',
        'amount': -150.00,
        'date': '2024-01-15',
        'time': '14:30',
        'status': 'completed',
        'icon': Icons.cleaning_services,
        'bookingId': 1234,
      },
      {
        'id': '2',
        'type': 'recharge',
        'title': 'Wallet Recharge',
        'description': 'Amount added to wallet',
        'amount': 500.00,
        'date': '2024-01-14',
        'time': '09:15',
        'status': 'completed',
        'icon': Icons.account_balance_wallet,
        'bookingId': null,
      },
      {
        'id': '3',
        'type': 'service_payment',
        'title': 'Office Cleaning',
        'description': 'Payment for service booking #1233',
        'amount': -200.00,
        'date': '2024-01-13',
        'time': '16:45',
        'status': 'completed',
        'icon': Icons.cleaning_services,
        'bookingId': 1233,
      },
      {
        'id': '4',
        'type': 'recharge',
        'title': 'Wallet Recharge',
        'description': 'Amount added to wallet',
        'amount': 1000.00,
        'date': '2024-01-12',
        'time': '11:20',
        'status': 'completed',
        'icon': Icons.account_balance_wallet,
        'bookingId': null,
      },
      {
        'id': '5',
        'type': 'service_payment',
        'title': 'Deep Cleaning Service',
        'description': 'Payment for service booking #1232',
        'amount': -300.00,
        'date': '2024-01-11',
        'time': '10:00',
        'status': 'completed',
        'icon': Icons.cleaning_services,
        'bookingId': 1232,
      },
    ];
  }

  void onRechargeWallet() {
    // Navigate to recharge screen or show recharge dialog

    print("${walletDetailsModel.value?.wallet?.first.userId} hiiii");

    Get.snackbar(
      'Recharge Wallet',
      'Recharge feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
    );
    // TODO: Navigate to recharge screen
    // Get.toNamed(AppRoutes.rechargeWallet);
  }

  void onViewTransactionHistory() {
    // Show all transactions or navigate to full history screen
    Get.snackbar(
      'Transaction History',
      'Showing all transactions...',
      snackPosition: SnackPosition.BOTTOM,
    );
    // TODO: Navigate to full transaction history screen
     Get.toNamed(AppRoutes.transactionsHistoryScreen);
  }

  String getTransactionTypeText(String type) {
    switch (type) {
      case 'recharge':
        return 'Recharge';
      case 'service_payment':
        return 'Service Payment';
      default:
        return 'Transaction';
    }
  }

  Color getTransactionTypeColor(String type) {
    switch (type) {
      case 'recharge':
        return AppColours.green;
      case 'service_payment':
        return AppColours.red;
      default:
        return AppColours.grey;
    }
  }
}