import '../../../utils/app_export.dart';
import 'booking_screen_controller.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});
  final BookingController controller = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SizedBox(
          height: AppStyle.heightPercent(context, 100),
          width: AppStyle.widthPercent(context, 100),
          child: Column(
            children: [
              // Header with Search
              _buildHeader(context),
              const SizedBox(height: 15),
              // Tab Bar
              SizedBox(
                width: AppStyle.widthPercent(context, 90),
                child: _buildTabBar(),
              ),
              const SizedBox(height: 15),
              // Content
              Expanded(child: Obx(() => _buildContent())),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: AppStyle.heightPercent(context, 18),
      width: AppStyle.widthPercent(context, 100),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: AppStyle.widthPercent(context, 90),
            child: Column(
              children: [
                // Title and Stats
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.bookings,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Filter Icon
                  
                  ],
                ),
                const SizedBox(height: 16),
                // Search Bar
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Icon(Icons.search, color: Colors.grey[600], size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          onChanged: controller.updateSearchQuery,
                          decoration: InputDecoration(
                            hintText: 'Search bookings...',
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontFamily: AppFonts.fontFamily,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: AppFonts.fontFamily,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Obx(
        () => Row(
          children: [
            _buildTabItem('Upcoming', 0, Icons.schedule),
            _buildTabItem('In Progress', 1, Icons.work),
            _buildTabItem('Completed', 2, Icons.check_circle),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index, IconData icon) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: controller.selectedTab.value == index
                ? AppColours.appColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: controller.selectedTab.value == index
                    ? Colors.white
                    : Colors.grey[600],
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: controller.selectedTab.value == index
                      ? Colors.white
                      : Colors.grey[600],
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final bookings = controller.filteredBookings;

    if (bookings.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return _buildBookingCard(bookings[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    String message = '';
    IconData icon = Icons.schedule;

    switch (controller.selectedTab.value) {
      case 0:
        message = 'No upcoming bookings';
        icon = Icons.schedule;
        break;
      case 1:
        message = 'No bookings in progress';
        icon = Icons.work;
        break;
      case 2:
        message = 'No completed bookings';
        icon = Icons.check_circle;
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'New bookings will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getStatusColor(booking['status']).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColours.appColor.withOpacity(0.1),
                  child: Text(
                    booking['customerName'][0],
                    style: TextStyle(
                      color: AppColours.appColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['customerName'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColours.black,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                      Text(
                        booking['serviceType'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking['status']),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(booking['status']),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Address
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        booking['address'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Date and Time
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      booking['date'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      booking['time'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Duration and Price
                Row(
                  children: [
                    Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      booking['duration'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      booking['price'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColours.appColor,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ],
                ),
                if (booking['notes'] != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.note, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            booking['notes'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                // Action Buttons
                _buildActionButtons(booking),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> booking) {
    String status = booking['status'];

    switch (status) {
      case 'upcoming':
        return Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => controller.acceptBooking(booking['id']),
                icon: const Icon(Icons.check, size: 18),
                label: const Text('Accept'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => controller.rejectBooking(booking['id']),
                icon: const Icon(Icons.close, size: 18),
                label: const Text('Reject'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        );
      case 'in_progress':
        return Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => controller.completeBooking(booking['id']),
                icon: const Icon(Icons.check_circle, size: 18),
                label: const Text('Complete'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColours.appColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Navigate to booking details or start timer
                },
                icon: const Icon(Icons.phone, size: 18),
                label: const Text('Call'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColours.appColor,
                  side: BorderSide(color: AppColours.appColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        );
      case 'completed':
        return Row(
          children: [
            if (booking['rating'] != null) ...[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${booking['rating']}/5',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // View booking details or customer feedback
                },
                icon: const Icon(Icons.visibility, size: 18),
                label: const Text('View Details'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColours.appColor,
                  side: BorderSide(color: AppColours.appColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'upcoming':
        return Colors.blue;
      case 'in_progress':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'upcoming':
        return 'UPCOMING';
      case 'in_progress':
        return 'IN PROGRESS';
      case 'completed':
        return 'COMPLETED';
      default:
        return 'UNKNOWN';
    }
  }
}
