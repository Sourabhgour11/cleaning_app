import 'package:flutter/material.dart';
import 'app_images.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';

class AppUserBottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onTabChanged;

  const AppUserBottomBar({
    super.key,
    this.currentIndex = 0,
    this.onTabChanged,
  });

  @override
  State<AppUserBottomBar> createState() => _AppUserBottomBarState();
}

class _AppUserBottomBarState extends State<AppUserBottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Color> colors = [
    AppColours.appColor,
    Colors.orange,
    Colors.green,
    Colors.deepPurple,
    Colors.blue,
  ];

  final List<String> labels = ['Home', 'Bookings', 'Wallet', 'Announcement', 'Profile'];

  final List<String> activeImages = [
    AppImages.homeActiveIcon,
    AppImages.bookingActiveIcon,
    AppImages.walletActiveIcon,
    AppImages.announcementActiveIcon,
    AppImages.profileActiveIcon,
  ];

  final List<String> inactiveImages = [
    AppImages.homeInactiveIcon,
    AppImages.bookingInactiveIcon,
    AppImages.walletInactiveIcon,
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

  void _resetBottomNav() {
    setState(() {
      // _currentIndex = 0; // always start at first tab
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColours.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive icon size based on screen width
            double maxWidth = constraints.maxWidth;
            double iconSize = maxWidth < 350 ? 22 : 26;
            double fontSize = maxWidth < 350 ? 10 : 11;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(labels.length, (index) {
                final bool isSelected = widget.currentIndex == index;

                return Expanded( // ✅ Each tab flexibly takes space
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (widget.currentIndex != index) {
                        widget.onTabChanged?.call(index);
                        _animationController.forward().then((_) {
                          _animationController.reverse();
                        });
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.all(isSelected ? 8 : 6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? colors[index].withOpacity(0.15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset(
                              isSelected
                                  ? activeImages[index]
                                  : inactiveImages[index],
                              width: isSelected ? iconSize + 2 : iconSize,
                              height: isSelected ? iconSize + 2 : iconSize,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Flexible(
                            child: Text(
                              labels[index],
                              overflow: TextOverflow.ellipsis, // ✅ Prevent text overflow
                              maxLines: 1,
                              style: TextStyle(
                                color: isSelected
                                    ? colors[index]
                                    : Colors.grey[600],
                                fontSize: fontSize,
                                fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                                fontFamily: AppFonts.fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),

    );
  }
}
