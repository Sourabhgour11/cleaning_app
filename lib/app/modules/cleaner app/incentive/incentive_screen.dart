import '../../../utils/app_export.dart';
import 'incentive_screen_controller.dart';

class IncentiveScreen extends StatelessWidget {
  const IncentiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IncentiveScreenController());

    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppStyle.heightPercent(context, 20)),
        child: _buildEarningsHeader(context, controller),
      ),
      body: SafeArea(child: Obx(() => _buildContent(context, controller))),
    );
  }

  Widget _buildContent(
    BuildContext context,
    IncentiveScreenController controller,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.refreshData();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          width: AppStyle.widthPercent(context, 100),
          child: Column(
            children: [
              SizedBox(height: AppStyle.heightPercent(context, 2)),
              // Earnings Summary Cards
              _buildEarningsSummary(context, controller),
              SizedBox(height: AppStyle.heightPercent(context, 2)),
              SizedBox(
                width: AppStyle.widthPercent(context, 90),
                child: _buildRecentIncentives(context, controller),
              ),
              SizedBox(height: AppStyle.heightPercent(context, 10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsHeader(
    BuildContext context,
    IncentiveScreenController controller,
  ) {
    return Container(
      width: AppStyle.widthPercent(context, 100),
      height: AppStyle.heightPercent(context, 25),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: AppColours.gradientColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: AppStyle.heightPercent(context, 5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const Text(
                AppStrings.myIncentive,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: AppFonts.fontFamily,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          SizedBox(height: AppStyle.heightPercent(context, 1)),
          // Total Earnings
          const Text(
            AppStrings.totalEarnings,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          SizedBox(height: AppStyle.heightPercent(context, 0.5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\$',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              SizedBox(width: AppStyle.widthPercent(context, 0.5)),
              Text(
                controller.totalEarnings.value.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: AppFonts.fontFamily,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsSummary(
    BuildContext context,
    IncentiveScreenController controller,
  ) {
    return SizedBox(
      width: AppStyle.widthPercent(context, 90),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: AppStyle.widthPercent(context, 26),
            child: _buildSummaryCard(
              context,
              AppStrings.thisMonth,
              controller.monthlyEarnings.value,
              Icons.calendar_today,
              AppColours.appColor,
            ),
          ),
          SizedBox(
            width: AppStyle.widthPercent(context, 26),
            child: _buildSummaryCard(
              context,
              AppStrings.thisWeek,
              controller.weeklyEarnings.value,
              Icons.date_range,
              Colors.green,
            ),
          ),
          SizedBox(
            width: AppStyle.widthPercent(context, 26),
            child: _buildSummaryCard(
              context,
              AppStrings.bonuses,
              controller.bonusEarnings.value,
              Icons.card_giftcard,
              Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: AppStyle.widthPercent(context, 90),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: AppStyle.heightPercent(context, 2)),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: AppStyle.heightPercent(context, 1.2)),
          Text(
            '\$${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          SizedBox(height: AppStyle.heightPercent(context, 0.4)),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: AppColours.grey,
              fontFamily: AppFonts.fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppStyle.heightPercent(context, 2)),
        ],
      ),
    );
  }

  Widget _buildIncentiveTypes(
    BuildContext context,
    IncentiveScreenController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppStrings.incentiveTypes,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColours.black,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                AppStrings.viewAll,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColours.appColor,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.incentiveCards.length,
            itemBuilder: (context, index) {
              final card = controller.incentiveCards[index];
              return _buildIncentiveCard(card);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIncentiveCard(Map<String, dynamic> card) {
    Color getColor(String colorName) {
      switch (colorName) {
        case 'orange':
          return Colors.orange;
        case 'blue':
          return Colors.blue;
        case 'purple':
          return Colors.purple;
        case 'green':
          return Colors.green;
        default:
          return AppColours.appColor;
      }
    }

    IconData getIcon(String iconName) {
      switch (iconName) {
        case 'trophy':
          return Icons.emoji_events;
        case 'timer':
          return Icons.timer;
        case 'star':
          return Icons.star;
        case 'people':
          return Icons.people;
        default:
          return Icons.card_giftcard;
      }
    }

    final color = getColor(card['color'] as String);
    final icon = getIcon(card['icon'] as String);

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const Spacer(),
          Text(
            card['title'] as String,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            card['description'] as String,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.8),
              fontFamily: AppFonts.fontFamily,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '\$${(card['amount'] as double).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements(IncentiveScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            AppStrings.achievementsProgress,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColours.black,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: controller.achievements.map((achievement) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildAchievementItem(achievement),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementItem(Map<String, dynamic> achievement) {
    final progress = achievement['progress'] as double;
    final current = achievement['current'] as int;
    final target = achievement['target'] as int;
    final reward = achievement['reward'] as double;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                achievement['title'] as String,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColours.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '\$$reward',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress >= 0.8
                        ? Colors.green
                        : progress >= 0.5
                        ? Colors.orange
                        : AppColours.appColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '$current/$target',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentIncentives(
    BuildContext context,
    IncentiveScreenController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: AppStyle.widthPercent(context, 90),
          child: Text(
            AppStrings.recentIncentives,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColours.black,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ),
        SizedBox(height: AppStyle.heightPercent(context, 2)),
        Container(
          width: AppStyle.widthPercent(context, 90),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: controller.recentIncentives.map((incentive) {
              return _buildIncentiveItem(context, incentive);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildIncentiveItem(
    BuildContext context,
    Map<String, dynamic> incentive,
  ) {
    return Container(
      width: AppStyle.widthPercent(context, 80),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: AppStyle.heightPercent(context, 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                ),
              ),
              SizedBox(
                width: AppStyle.widthPercent(context, 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      incentive['title'] as String,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColours.black,
                        fontFamily: AppFonts.fontFamily,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 12,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          incentive['date'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontFamily: AppFonts.fontFamily,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            incentive['status'] as String,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 4),
                  ],
                ),
              ),
              Text(
                '+\$${(incentive['amount'] as double).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ],
          ),
          SizedBox(height: AppStyle.heightPercent(context, 1)),
        ],
      ),
    );
  }
}
