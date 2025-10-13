import 'app_export.dart';

// Modern Floating Bottom Bar - Similar to the GIF design
class CleanerModernBottomBar extends StatefulWidget {
  const CleanerModernBottomBar({
    super.key,
    this.onTabChanged,
    this.currentIndex = 0,
  });

  final Function(int)? onTabChanged;
  final int currentIndex;

  @override
  _CleanerModernBottomBarState createState() => _CleanerModernBottomBarState();
}

class _CleanerModernBottomBarState extends State<CleanerModernBottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Color> colors = [
    AppColours.appColor,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  final List<String> labels = [
    'Home',
    'Bookings',
    'Inbox',
    'Announcements',
    'Profile',
  ];

  final List<String> activeImages = [
    AppImages.homeActiveIcon,
    AppImages.bookingActiveIcon,
    AppImages.inboxActiveIcon,
    AppImages.announcementActiveIcon,
    AppImages.profileActiveIcon,
  ];

  final List<String> inactiveImages = [
    AppImages.homeInactiveIcon,
    AppImages.bookingInactiveIcon,
    AppImages.inboxInactiveIcon,
    AppImages.announcementInactiveIcon,
    AppImages.profileInactiveIcon,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      // height: 85,
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppColours.appColor.withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(5, (index) {
          final isSelected = widget.currentIndex == index;
          return GestureDetector(
            onTap: () {
              widget.onTabChanged?.call(index);
              _animationController.forward().then((_) {
                _animationController.reverse();
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(isSelected ? 10 : 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colors[index].withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      isSelected ? activeImages[index] : inactiveImages[index],
                      width: isSelected ? 28 : 24,
                      height: isSelected ? 28 : 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    labels[index],
                    style: TextStyle(
                      color: isSelected ? colors[index] : Colors.grey[600],
                      fontSize: 11,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
