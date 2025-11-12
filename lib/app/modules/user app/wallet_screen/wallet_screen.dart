import 'package:cleaning_app/app/data/models/get_wallet_details_model.dart';
import 'package:cleaning_app/app/utils/app_constants.dart';
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

            // Recent Transactions
            _buildRecentTransactions(controller),

            SizedBox(height: AppStyle.heightPercent(context, 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletBalanceCard(WalletScreenController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
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
          const SizedBox(height: 16),
          Obx(
            () => Text(
              '${AppConstants.currency}${controller.walletDetailsModel.value?.totalBalance}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: controller.onRechargeWallet,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: AppColours.appColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Recharge Wallet',
                    style: TextStyle(
                      color: AppColours.appColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
              GestureDetector(
                onTap: (){
                  // print("${controller.walletDetailsModel.value?.wallet?.first.userId} hiiii");
                  controller.getWalletDetailsApi();
                },
                child: const Text(
                  AppStrings.recentTransactions,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.fontFamily,
                    color: AppColours.black,
                  ),
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
            () => (controller.walletDetailsModel.value.isNull)
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(40),
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
                      child: Column(
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No transactions yet',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
              itemCount: (controller.walletDetailsModel.value?.wallet?.length ?? 0) > 10
                  ? 10
                  : (controller.walletDetailsModel.value?.wallet?.length ?? 0),

              itemBuilder: (context, index) {
                      final transaction = controller.walletDetailsModel.value?.wallet?[index];
                      return _buildTransactionTile(transaction!, controller);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(
    Wallet transaction,
    WalletScreenController controller,
  ) {
    final isPositive = transaction.walletAmount! > 0;
    final amountColor = isPositive ? AppColours.green : AppColours.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:transaction.amountStatus ==1 ? Colors.green
                  .withOpacity(0.1) : Colors.red
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: transaction.amountStatus == 0 ? Icon(
              Icons.cleaning_services,
              color:transaction.amountStatus ==1 ? Colors.green : Colors.red,size: 24,) : Icon(
              Icons.account_balance_wallet,
              color:transaction.amountStatus ==1 ? Colors.green : Colors.red,size: 24,),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.categoryName ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.fontFamily,
                    color: AppColours.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.subCategoryName ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${transaction.createtime}',
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
                // '${isPositive ? '+' : '-'}\$${transaction.createtime}',
                '${AppConstants.currency} 150',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:transaction.amountStatus ==1 ? Colors.green : Colors.red,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: transaction.paymentStatus == 1 ? AppColours.green.withOpacity(0.1) : AppColours.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(transaction.paymentStatus == 1 ? "COMPLETED" : "PENDING",
                  // transaction['status'].toString().toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color:
                    transaction.paymentStatus == 1 ? AppColours.green
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
  }
}
