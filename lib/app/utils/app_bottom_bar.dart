import 'app_export.dart';

// Modern Floating Bottom Bar - Similar to the GIF design
class ModernBottomBar extends StatefulWidget {
  const ModernBottomBar({super.key, this.onTabChanged, this.currentIndex = 0});

  final Function(int)? onTabChanged;
  final int currentIndex;

  @override
  _ModernBottomBarState createState() => _ModernBottomBarState();
}

// LinkedIn-style Bottom Bar - Always visible and stable
class LinkedInBottomBar extends StatefulWidget {
  const LinkedInBottomBar({
    super.key,
    this.onTabChanged,
    this.currentIndex = 0,
  });

  final Function(int)? onTabChanged;
  final int currentIndex;

  @override
  _LinkedInBottomBarState createState() => _LinkedInBottomBarState();
}

// Floating Tab Bar component with modern design (keeping for backward compatibility)
class FloatingTabBar extends StatefulWidget {
  const FloatingTabBar({
    super.key,
    this.onTabChanged,
    this.currentIndex = 0,
    this.isVisible = true,
  });

  final Function(int)? onTabChanged;
  final int currentIndex;
  final bool isVisible;

  @override
  _FloatingTabBarState createState() => _FloatingTabBarState();
}

// Custom bottom bar component that can be used within existing screens
class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key, this.onTabChanged, this.currentIndex = 0});
  final Function(int)? onTabChanged;
  final int currentIndex;

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _ModernBottomBarState extends State<ModernBottomBar>
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

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.calendar_today_rounded,
    Icons.inbox_rounded,
    Icons.announcement_rounded,
    Icons.person_rounded,
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
                    child: Icon(
                      icons[index],
                      size: isSelected ? 28 : 24,
                      color: isSelected ? colors[index] : Colors.grey[600],
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

class _LinkedInBottomBarState extends State<LinkedInBottomBar>
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

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.calendar_today_rounded,
    Icons.inbox_rounded,
    Icons.announcement_rounded,
    Icons.person_rounded,
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
      height: 65,
      decoration: BoxDecoration(
        color: AppColours.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(isSelected ? 8 : 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colors[index].withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icons[index],
                      size: isSelected ? 26 : 22,
                      color: isSelected ? colors[index] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    labels[index],
                    style: TextStyle(
                      color: isSelected ? colors[index] : Colors.grey[600],
                      fontSize: 10,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
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

class _CustomBottomBarState extends State<CustomBottomBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
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
    'Profile',
    'Settings',
  ];
  final List<IconData> icons = [
    Icons.home,
    Icons.calendar_today,
    Icons.inbox,
    Icons.person,
    Icons.settings,
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: widget.currentIndex,
    );
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        widget.onTabChanged?.call(tabController.index);
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColours.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        indicator: const BoxDecoration(),
        labelColor: AppColours.appColor,
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        tabs: List.generate(5, (index) {
          return Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icons[index],
                  size: 24,
                  color: widget.currentIndex == index
                      ? colors[index]
                      : Colors.grey,
                ),
                const SizedBox(height: 4),
                Text(
                  labels[index],
                  style: TextStyle(
                    color: widget.currentIndex == index
                        ? colors[index]
                        : Colors.grey,
                    fontSize: 10,
                    fontWeight: widget.currentIndex == index
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _FloatingTabBarState extends State<FloatingTabBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

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

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.calendar_today_rounded,
    Icons.inbox_rounded,
    Icons.announcement_rounded,
    Icons.person_rounded,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(20),
                height: 70,
                decoration: BoxDecoration(
                  color: AppColours.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
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
                  children: List.generate(5, (index) {
                    final isSelected = widget.currentIndex == index;
                    return GestureDetector(
                      onTap: () {
                        widget.onTabChanged?.call(index);
                        // Don't reset animation on tap to prevent hiding
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colors[index].withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.all(isSelected ? 8 : 6),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? colors[index]
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                icons[index],
                                size: isSelected ? 24 : 20,
                                color: isSelected
                                    ? AppColours.white
                                    : Colors.grey[600],
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(height: 4),
                              Text(
                                labels[index],
                                style: TextStyle(
                                  color: colors[index],
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.fontFamily,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
