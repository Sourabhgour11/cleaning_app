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
    Colors.blue,
  ];

  final List<String> labels = ['Home', 'Bookings', 'Wallet', 'Profile'];

  final List<String> activeImages = [
    AppImages.homeActiveIcon,
    AppImages.bookingActiveIcon,
    AppImages.walletActiveIcon,
    AppImages.profileActiveIcon,
  ];

  final List<String> inactiveImages = [
    AppImages.homeInactiveIcon,
    AppImages.bookingInactiveIcon,
    AppImages.walletInactiveIcon,
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
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.symmetric(vertical: 8),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(labels.length, (index) {
            final bool isSelected = widget.currentIndex == index;

            return GestureDetector(
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.all(isSelected ? 10 : 8),
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
                        width: isSelected ? 28 : 24,
                        height: isSelected ? 28 : 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      labels[index],
                      style: TextStyle(
                        color: isSelected ? colors[index] : Colors.grey[600],
                        fontSize: 11,
                        fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
