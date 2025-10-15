import 'package:cleaning_app/app/utils/app_export.dart';

import 'wallet_screen_controller.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletScreenController controller = Get.put(WalletScreenController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppStyle.appBarStyle(AppStrings.myWallet, isBackButton: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: AppStyle.heightPercent(context, 2)),

            // Wallet Balance Card
            _buildWalletBalanceCard(controller),

            SizedBox(height: AppStyle.heightPercent(context, 2)),

            // Quick Actions Grid
            _buildQuickActionsGrid(controller),

            SizedBox(height: AppStyle.heightPercent(context, 2)),

            // Recent Transactions
            _buildRecentTransactions(controller),

            SizedBox(height: AppStyle.heightPercent(context, 2)),

            // Payment Methods
            _buildPaymentMethods(controller),

            SizedBox(height: AppStyle.heightPercent(context, 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletBalanceCard(WalletScreenController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColours.appColor, AppColours.appColor2],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColours.appColor.withOpacity(0.3),
            offset: const Offset(0, 8),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.walletBalance,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  AppStrings.active,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Obx(
            () => Text(
              '\$${controller.walletBalance.value.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildBalanceInfo(
                  AppStrings.totalEarnings,
                  '\$${controller.totalEarnings.value.toStringAsFixed(2)}',
                  Icons.trending_up,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildBalanceInfo(
                  AppStrings.pending,
                  '\$${controller.pendingAmount.value.toStringAsFixed(2)}',
                  Icons.schedule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceInfo(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid(WalletScreenController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.quickActions,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.fontFamily,
              color: AppColours.black,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: controller.quickActions.length,
              itemBuilder: (context, index) {
                final action = controller.quickActions[index];
                return _buildQuickActionCard(action, controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    Map<String, dynamic> action,
    WalletScreenController controller,
  ) {
    return GestureDetector(
      onTap: () {
        switch (action['title']) {
          case AppStrings.addPaymentMethod:
            controller.onAddPaymentMethod();
            break;
          case AppStrings.transactionHistory:
            controller.onViewTransactionHistory();
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (action['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(action['icon'], color: action['color'], size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              action['title'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.fontFamily,
                color: AppColours.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              action['subtitle'],
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
                fontFamily: AppFonts.fontFamily,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions(WalletScreenController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.recentTransactions,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.fontFamily,
                  color: AppColours.black,
                ),
              ),
              TextButton(
                onPressed: controller.onViewTransactionHistory,
                child: const Text(
                  AppStrings.viewAll,
                  style: TextStyle(
                    color: AppColours.appColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.transactions.take(5).length,
              itemBuilder: (context, index) {
                final transaction = controller.transactions[index];
                return _buildTransactionTile(transaction, controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(
    Map<String, dynamic> transaction,
    WalletScreenController controller,
  ) {
    final isPositive = transaction['amount'] > 0;
    final amountColor = isPositive ? AppColours.green : AppColours.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: controller
                  .getTransactionTypeColor(transaction['type'])
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              transaction['icon'],
              color: controller.getTransactionTypeColor(transaction['type']),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.fontFamily,
                    color: AppColours.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction['description'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${transaction['date']} • ${transaction['time']}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: transaction['status'] == 'completed'
                            ? AppColours.green.withOpacity(0.1)
                            : AppColours.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        transaction['status'].toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: transaction['status'] == 'completed'
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
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isPositive ? '+' : ''}\$${transaction['amount'].abs().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: amountColor,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                controller.getTransactionTypeText(transaction['type']),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(WalletScreenController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.paymentMethods,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.fontFamily,
                  color: AppColours.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.paymentMethods.length,
              itemBuilder: (context, index) {
                final method = controller.paymentMethods[index];
                return _buildPaymentMethodTile(method);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTile(Map<String, dynamic> method) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: method['isDefault']
            ? Border.all(color: AppColours.appColor.withOpacity(0.3), width: 1)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColours.appColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(method['icon'], color: AppColours.appColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      method['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.fontFamily,
                        color: AppColours.black,
                      ),
                    ),
                    if (method['isDefault']) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColours.appColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          AppStrings.defaultText,
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColours.appColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${method['bankName']} • ${method['accountNumber']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
        ],
      ),
    );
  }
}
