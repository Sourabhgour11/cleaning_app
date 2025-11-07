import 'package:cleaning_app/app/modules/user%20app/favourites_screen/favourites_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_export.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({super.key});

  final FavouritesScreenController controller = Get.put(
    FavouritesScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyle.appBarStyle(AppStrings.favourites),
      body: SizedBox(
        // height: double.infinity,
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap:
              true, // Important: makes GridView take only required height
          physics:
              const NeverScrollableScrollPhysics(), // Prevent inner scrolling if inside another scroll
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3 / 2,
          ),
          itemCount:
              controller.generalCleaning.length, // Dynamic number of items
          itemBuilder: (context, index) {
            final item = controller.generalCleaning[index];
            return InkWell(
              onTap: () {
                // Show service popup instead of navigating to booking
                // controller.showServicePopup(index);
              },
              child: Stack(
                children: [
                  // Image with dark overlay
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6), // smaller radius
                    child: Stack(
                      children: [
                        Image.asset(
                          item['image'],
                          // width: MediaQuery.of(context).size.width*20/100,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width*20/100,
                          height: double.infinity,
                          color: Colors.black.withOpacity(0.4), // dark overlay
                        ),
                        Positioned(
                          right: 10,
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Icon(Icons.favorite, color: Colors.red),
                          ),
                        ),
                        Positioned(
                          bottom: 6,
                          left: 6,
                          child: SizedBox(
                            width: 110,
                            child: Text(
                              item['name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: AppFonts.fontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
