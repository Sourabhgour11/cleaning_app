import 'package:cleaning_app/app/utils/app_export.dart';
import 'transaction_history_screen_controller.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionHistoryScreenController controller = Get.put(
      TransactionHistoryScreenController(),
    );

    return Scaffold(
      // appBar: AppStyle.appBarStyle(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColours.appColor,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: AppColours.gradientColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
        ),
        leading: true
            ? Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: IconButton(
                  onPressed: () => Get.back(),
                  color: AppColours.white,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                ),
              )
            : null,
        title: Text(
          "Transactions",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColours.white,
            fontFamily: AppFonts.fontFamily,
            letterSpacing: 0.5,
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        actions: [
          // 🔽 The Obx filter icon logic preserved from your original code
          Obx(() {
            final hasDateFilter =
                controller.startDate.value != null &&
                controller.endDate.value != null;
            return Container(
              margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: IconButton(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.filter_list_rounded,
                      color: AppColours.white,
                    ),
                    if (hasDateFilter)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColours.appColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () => controller.openDateRangePicker(context),
                tooltip: 'Filter by date',
              ),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColours.gradientColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Container(
                        // Inner translucent container (acts as border space)
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(27),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                            width: 1,
                          ),
                        ),
                        child: TabBar(
                          onTap: controller.onChangeTab,
                          labelColor: AppColours.appColor,
                          unselectedLabelColor: Colors.white.withOpacity(0.9),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            fontFamily: AppFonts.fontFamily,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: AppFonts.fontFamily,
                          ),
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: AppColours.appColor.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          // ✅ fills tab height
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          tabs: const [
                            Tab(text: 'All'),
                            Tab(text: 'Debited'),
                            Tab(text: 'Credited'),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Obx(() {
                  final hasDateFilter =
                      controller.startDate.value != null &&
                      controller.endDate.value != null;
                  if (!hasDateFilter) return const SizedBox.shrink();
                  final s = controller.startDate.value!;
                  final e = controller.endDate.value!;
                  final range =
                      '${s.year}-${s.month.toString().padLeft(2, '0')}-${s.day.toString().padLeft(2, '0')}'
                      '  to  '
                      '${e.year}-${e.month.toString().padLeft(2, '0')}-${e.day.toString().padLeft(2, '0')}';
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColours.appColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          size: 16,
                          color: AppColours.appColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          range,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColours.appColor,
                            fontFamily: AppFonts.fontFamily,
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: controller.clearDateFilter,
                          child: const Icon(
                            Icons.close,
                            size: 14,
                            color: AppColours.appColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              final txns = controller.filteredTransactions;
              if (txns.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 56,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'No transactions found',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: txns.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final t = txns[index];
                  final bool isPositive =
                      (t['amount'] ?? 0) is num && (t['amount'] as num) > 0;
                  final Color amountColor = isPositive
                      ? AppColours.green
                      : AppColours.red;
                  final String amountText =
                      '${isPositive ? '+' : '-'}\$${(t['amount'] as num).abs().toStringAsFixed(2)}';

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.08),
                          offset: const Offset(0, 1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                (isPositive ? AppColours.green : AppColours.red)
                                    .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            t['icon'] ??
                                (isPositive
                                    ? Icons.account_balance_wallet
                                    : Icons.cleaning_services),
                            color: isPositive
                                ? AppColours.green
                                : AppColours.red,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (t['title'] ?? '').toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.fontFamily,
                                  color: AppColours.black,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                (t['description'] ?? '').toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontFamily: AppFonts.fontFamily,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${t['date'] ?? ''}${(t['time'] ?? '').toString().isNotEmpty ? ' • ${t['time']}' : ''}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[500],
                                  fontFamily: AppFonts.fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              amountText,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: amountColor,
                                fontFamily: AppFonts.fontFamily,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    (t['status'] == 'completed'
                                            ? AppColours.green
                                            : AppColours.orange)
                                        .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                (t['status'] ?? 'completed')
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: t['status'] == 'completed'
                                      ? AppColours.green
                                      : AppColours.orange,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
