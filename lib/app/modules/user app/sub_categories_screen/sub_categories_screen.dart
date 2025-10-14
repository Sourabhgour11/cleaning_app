import 'package:cleaning_app/app/utils/app_export.dart';

import 'sub_categories_screen_controller.dart';

class SubCategoriesScreen extends StatelessWidget {
  SubCategoriesScreen({super.key});

  final SubCategoriesScreenController controller = Get.put(
    SubCategoriesScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyle.appBarStyle(controller.appBarTitle.value),
      body: GestureDetector(
        onTap: (){
          controller.hideServicePopup();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    // height: double.infinity,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      shrinkWrap:
                          true, // Important: makes GridView take only required height
                      physics:
                          const NeverScrollableScrollPhysics(), // Prevent inner scrolling if inside another scroll
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 items per row
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 3 / 2,
                          ),
                      itemCount: controller
                          .generalCleaning
                          .length, // Dynamic number of items
                      itemBuilder: (context, index) {
                        final item = controller.generalCleaning[index];
                        return InkWell(
                          onTap: () {
                            // Show service popup instead of navigating to booking
                            controller.showServicePopup(index);
                          },
                          child: Stack(
                            children: [
                              // Image with dark overlay
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  6,
                                ), // smaller radius
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
                                      color: Colors.black.withOpacity(
                                        0.4,
                                      ), // dark overlay
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
                ],
              ),
            ),

            // Service Details Popup
            Obx(() => controller.isServicePopupVisible.value
              ? _buildServicePopup(controller)
              : const SizedBox.shrink()
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicePopup(SubCategoriesScreenController controller) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Obx(() => _buildServiceContent(controller,context)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceContent(SubCategoriesScreenController controller,BuildContext context) {
    final service = controller.currentService;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Handle bar
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        
        // Customize label
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Customize',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red[600],
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ),
        
        // What's Included section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What's Included:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...service['whatsIncluded']
                            .map<Widget>(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green[600],
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontFamily: AppFonts.fontFamily,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Service image
                  Container(
                    width: 120,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(service['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: controller.toggleServiceFavorite,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                controller.isServiceFavorited.value
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: controller.isServiceFavorited.value
                                    ? Colors.red
                                    : Colors.grey,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Service details and pricing
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service['subtitle'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    service['duration'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      service['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    controller.getFormattedPrice(service['discountedPrice']),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    controller.getFormattedPrice(service['originalPrice']),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                      decoration: TextDecoration.lineThrough,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                service['fullDescription'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // What We Bring section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What We Bring:",
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              const SizedBox(height: 8),
              ...service['whatWeBring'].map<Widget>((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[600],
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Know This Before You Book section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Know This Before You Book:",
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
              const SizedBox(height: 8),
              ...service['bookingNotes']
                  .map<Widget>(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.only(top: 6, right: 8),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                                fontFamily: AppFonts.fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Quantity selector and Add button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Quantity selector
              Row(
                children: [
                  GestureDetector(
                    onTap: controller.decreaseQuantity,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Obx(
                    () => Text(
                      controller.serviceQuantity.value.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: controller.increaseQuantity,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColours.appColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Add button
           SizedBox(
             height: AppStyle.heightPercent(context, 5),
             width: AppStyle.widthPercent(context, 55),
             child: AppButton(onPressed: (){
               controller.addServiceToCart(controller.appBarTitle);
             }, title: "Add for ${controller.getFormattedPrice(controller.totalServicePrice)}",),
           )
            ],
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}
