import 'package:cleaning_app/app/utils/app_export.dart';

class AddOnService {
  final String id;
  final String title;
  final String image;
  final double price;
  final double originalPrice;
  final String description;

  AddOnService({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.originalPrice,
    required this.description,
  });
}

class BookServiceStep2ScreenController extends GetxController {
  // Observable list of selected add-ons
  final RxList<String> selectedAddOns = <String>[].obs;
  
  // Base service price (this would come from previous step)
  final RxDouble baseServicePrice = 209.0.obs;

  var appBarTitle = "".obs;

  @override
  void onInit() {
    super.onInit();
    appBarTitle.value = Get.arguments.toString();
  }


  // Add-on services data
  final List<AddOnService> addOnServices = [
    AddOnService(
      id: '1',
      title: 'Under Eye Pads',
      image: 'lib/assets/images/woman\'s_spa.jpg',
      price: 25.0,
      originalPrice: 35.0,
      description: 'Soothing under eye treatment',
    ),
    AddOnService(
      id: '2',
      title: 'Hyaluronic Sheet Mask',
      image: 'lib/assets/images/mans_spa.jpg',
      price: 39.0,
      originalPrice: 55.0,
      description: 'Hydrating sheet mask treatment',
    ),
    AddOnService(
      id: '3',
      title: 'Single - 30 mins Extension',
      image: 'lib/assets/images/woman_salon.webp',
      price: 49.0,
      originalPrice: 80.0,
      description: 'Extended facial massage session',
    ),
    AddOnService(
      id: '4',
      title: 'Herbal Clean Up',
      image: 'lib/assets/images/mans_salon.jpg',
      price: 89.0,
      originalPrice: 120.0,
      description: 'Natural herbal facial treatment',
    ),
    AddOnService(
      id: '5',
      title: 'Body Scrub',
      image: 'lib/assets/images/spray_tanning.jpg',
      price: 99.0,
      originalPrice: 150.0,
      description: 'Exfoliating body scrub treatment',
    ),
    AddOnService(
      id: '6',
      title: 'Vitamin C Sheet Mask',
      image: 'lib/assets/images/lashes_brows.webp',
      price: 39.0,
      originalPrice: 55.0,
      description: 'Brightening vitamin C treatment',
    ),
    AddOnService(
      id: '7',
      title: 'Retinol Sheet Mask',
      image: 'lib/assets/images/makeup.jpg',
      price: 39.0,
      originalPrice: 55.0,
      description: 'Anti-aging retinol treatment',
    ),
    AddOnService(
      id: '8',
      title: 'Soothing Face Mask',
      image: 'lib/assets/images/nail_extension.jpg',
      price: 39.0,
      originalPrice: 60.0,
      description: 'Calming and soothing facial mask',
    ),
  ];

  // Get total price including selected add-ons
  double get totalPrice {
    double addOnTotal = selectedAddOns.fold(0.0, (sum, addOnId) {
      final addOn = addOnServices.firstWhere((service) => service.id == addOnId);
      return sum + addOn.price;
    });
    return baseServicePrice.value + addOnTotal;
  }

  // Toggle add-on selection
  void toggleAddOn(String addOnId) {
    if (selectedAddOns.contains(addOnId)) {
      selectedAddOns.remove(addOnId);
      update();
    } else {
      selectedAddOns.add(addOnId);
      update();
    }
  }

  // Check if add-on is selected
  bool isAddOnSelected(String addOnId) {
    return selectedAddOns.contains(addOnId);
  }

  // Navigate to next step
  void goToNextStep() {
    // TODO: Navigate to next step with selected add-ons
    Get.snackbar('Success', 'Add-ons selected successfully!');
  }

  // void showBookingSummaryBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return DraggableScrollableSheet(
  //         initialChildSize: 0.55,
  //         minChildSize: 0.4,
  //         maxChildSize: 0.9,
  //         expand: false,
  //         builder: (_, scrollController) {
  //           return Stack(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16),
  //                 child: ListView(
  //                   controller: scrollController,
  //                   children: [
  //                     const SizedBox(height: 10),
  //
  //                     // Drag handle
  //                     Center(
  //                       child: Container(
  //                         width: 40,
  //                         height: 4,
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey[400],
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 16),
  //
  //                     // Summary Title
  //                     const Text(
  //                       "Summary",
  //                       style: TextStyle(
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 16),
  //
  //                     // Service Card
  //                     Container(
  //                       padding: const EdgeInsets.all(16),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(12),
  //                         border: Border.all(color: Colors.grey.shade300),
  //                       ),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           const Text(
  //                             "Single - 60 mins",
  //                             style: TextStyle(
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w600,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                           const SizedBox(height: 8),
  //                           Row(
  //                             children: [
  //                               const Text(
  //                                 "AED 249",
  //                                 style: TextStyle(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                               const SizedBox(width: 8),
  //                               Text(
  //                                 "AED 350",
  //                                 style: TextStyle(
  //                                   fontSize: 14,
  //                                   color: Colors.grey[500],
  //                                   decoration: TextDecoration.lineThrough,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //
  //                     const SizedBox(height: 16),
  //
  //                     // Payment Summary
  //                     Container(
  //                       padding: const EdgeInsets.all(16),
  //                       decoration: BoxDecoration(
  //                         color: Colors.grey[100],
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           const Text(
  //                             "Payment Summary",
  //                             style: TextStyle(
  //                               fontSize: 15,
  //                               fontWeight: FontWeight.w600,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                           const SizedBox(height: 12),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: const [
  //                               Text("Subtotal", style: TextStyle(fontSize: 14)),
  //                               Text("AED 249.00",
  //                                   style: TextStyle(
  //                                       fontSize: 14,
  //                                       fontWeight: FontWeight.w500)),
  //                             ],
  //                           ),
  //                           const SizedBox(height: 8),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   const Text("Service Fee",
  //                                       style: TextStyle(fontSize: 14)),
  //                                   const SizedBox(width: 4),
  //                                   Icon(Icons.info_outline,
  //                                       size: 16, color: Colors.grey[500]),
  //                                 ],
  //                               ),
  //                               const Text("AED 9.00",
  //                                   style: TextStyle(
  //                                       fontSize: 14,
  //                                       fontWeight: FontWeight.w500)),
  //                             ],
  //                           ),
  //                           const Divider(height: 24),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: const [
  //                               Text(
  //                                 "Total (inc. VAT)",
  //                                 style: TextStyle(
  //                                   fontSize: 15,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "AED 258.00",
  //                                 style: TextStyle(
  //                                   fontSize: 15,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //
  //                     const SizedBox(height: 100),
  //                   ],
  //                 ),
  //               ),
  //
  //               // Bottom Fixed Bar
  //               Positioned(
  //                 left: 0,
  //                 right: 0,
  //                 bottom: 0,
  //                 child: Container(
  //                   padding:
  //                   const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //                   decoration: const BoxDecoration(
  //                     color: Colors.white,
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.black12,
  //                         blurRadius: 6,
  //                         offset: Offset(0, -2),
  //                       ),
  //                     ],
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: const [
  //                           Text(
  //                             "Total",
  //                             style: TextStyle(fontSize: 13, color: Colors.grey),
  //                           ),
  //                           Text(
  //                             "AED 258.00",
  //                             style: TextStyle(
  //                               fontSize: 17,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           // Handle next action
  //                         },
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: Color(0xFFFFC107), // yellow
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           padding: const EdgeInsets.symmetric(
  //                               horizontal: 32, vertical: 14),
  //                         ),
  //                         child: const Text(
  //                           "Next",
  //                           style: TextStyle(
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.w600,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }


}