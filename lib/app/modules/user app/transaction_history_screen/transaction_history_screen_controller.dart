import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:get/get.dart';

import '../wallet_screen/wallet_screen_controller.dart';

class TransactionHistoryScreenController extends GetxController{
  final RxList<Map<String, dynamic>> allTransactions = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredTransactions = <Map<String, dynamic>>[].obs;

  // 0 = All, 1 = Debited, 2 = Credited
  final RxInt selectedTabIndex = 0.obs;

  final Rx<DateTime?> startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> endDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();

    // Populate from WalletScreenController if available
    if (Get.isRegistered<WalletScreenController>()) {
      final wallet = Get.find<WalletScreenController>();
      allTransactions.assignAll(wallet.transactions);
    }

    // If launched with arguments containing transactions
    final args = Get.arguments;
    if (args is List<Map<String, dynamic>>) {
      allTransactions.assignAll(args);
    }

    applyFilters();
  }

  void onChangeTab(int index) {
    selectedTabIndex.value = index;
    applyFilters();
  }

  Future<void> openDateRangePicker(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialStart = startDate.value ?? now.subtract(const Duration(days: 7));
    final DateTime initialEnd = endDate.value ?? now;

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 2),
      initialDateRange: DateTimeRange(start: initialStart, end: initialEnd),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColours.appColor,
              onPrimary: Colors.white,
              onSurface: AppColours.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      startDate.value = DateTime(picked.start.year, picked.start.month, picked.start.day);
      endDate.value = DateTime(picked.end.year, picked.end.month, picked.end.day, 23, 59, 59);
      applyFilters();
    }
  }

  void clearDateFilter() {
    startDate.value = null;
    endDate.value = null;
    applyFilters();
  }

  void applyFilters() {
    List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(allTransactions);

    // Date filter
    if (startDate.value != null && endDate.value != null) {
      results = results.where((t) {
        final String dateStr = (t['date'] ?? '').toString();
        DateTime? d;
        try {
          d = DateTime.parse(dateStr.length >= 10 ? dateStr.substring(0, 10) : dateStr);
        } catch (_) {}
        if (d == null) return false;
        return !d.isBefore(startDate.value!) && !d.isAfter(endDate.value!);
      }).toList();
    }

    // Tab filter
    if (selectedTabIndex.value == 1) {
      // Debited: amount < 0
      results = results.where((t) => (t['amount'] ?? 0) is num && (t['amount'] as num) < 0).toList();
    } else if (selectedTabIndex.value == 2) {
      // Credited: amount > 0
      results = results.where((t) => (t['amount'] ?? 0) is num && (t['amount'] as num) > 0).toList();
    }

    // Sort newest first if 'date' exists
    results.sort((a, b) => (b['date'] ?? '').toString().compareTo((a['date'] ?? '').toString()));

    filteredTransactions.assignAll(results);
  }
}
