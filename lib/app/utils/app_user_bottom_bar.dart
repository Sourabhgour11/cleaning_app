import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'app_images.dart';

// Modern Floating Bottom Bar - Similar to the GIF design
class AppUserBottomBar extends StatefulWidget {
  const AppUserBottomBar({super.key, this.onTabChanged, this.currentIndex = 0});

  final Function(int)? onTabChanged;
  final int currentIndex;

  @override
  _AppUserModernBottomBarState createState() => _AppUserModernBottomBarState();
}

class _AppUserModernBottomBarState extends State<AppUserBottomBar>
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
            color: AppColours.appColor.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(4, (index) {
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      isSelected ? activeImages[index] : inactiveImages[index],
                      width: isSelected ? 28 : 24,
                      height: isSelected ? 28 : 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // const SizedBox(height: 4),
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
