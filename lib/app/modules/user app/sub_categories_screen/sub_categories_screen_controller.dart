import 'package:cleaning_app/app/utils/app_export.dart';

class SubCategoriesScreenController extends GetxController {

  RxString appBarTitle = ''.obs;

  final List<Map<String, dynamic>> generalCleaning = [
    {'name': 'Home Cleaning', 'image': "lib/assets/images/home_cleaning.jpg"},
    {'name': 'Furniture Cleaning', 'image': "lib/assets/images/furniture_cleaning.png"},
    {'name': 'Home Deep Cleaning', 'image': "lib/assets/images/home_deep_cleaning.webp"},
    {'name': 'Kitchen & Bathroom Deep Cleaning', 'image': "lib/assets/images/kitchen_bathroom_cleaning.webp"},
    {'name': 'Laundry & Deep Cleaning', 'image': "lib/assets/images/laundry_drycleaning.png"},
    {'name': 'AC Cleaning', 'image': "lib/assets/images/ac_cleaning.webp"},
    {'name': 'Car Wash', 'image': "lib/assets/images/car_wash.webp"},
  ];

  // Service popup data
  final RxBool isServicePopupVisible = false.obs;
  final RxInt selectedServiceIndex = 0.obs;
  final RxInt serviceQuantity = 1.obs;
  final RxBool isServiceFavorited = false.obs;

  // Service details data
  final RxList<Map<String, dynamic>> serviceDetails = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      appBarTitle.value = Get.arguments.toString();
    }
    _initializeServiceDetails();
  }

  void _initializeServiceDetails() {
    serviceDetails.value = [
      {
        'id': '1',
        'title': 'Home Cleaning',
        'subtitle': 'Single - 90 mins (25% off)',
        'duration': '90 min.',
        'description': 'A gentle cleaning to increased home hygiene and cleanliness.',
        'fullDescription': 'Relax, unwind & feel balanced with a rejuvenating cleaning experience.',
        'originalPrice': 300.0,
        'discountedPrice': 229.0,
        'discountPercentage': 25,
        'image': 'lib/assets/images/home_cleaning.jpg',
        'whatsIncluded': [
          'Long Flowing Strokes for Circulation',
          'Deep Pressure Targets Knots',
          'Choice of 3 Aroma Oils',
        ],
        'whatWeBring': [
          'Professional cleaning equipment',
          'Fresh, single-use supplies & towels',
          'Fully sanitized setup for a safe, clean experience',
          'Trained professional focused on quality & care',
        ],
        'bookingNotes': [
          'For residential properties only',
          'Not suitable during major renovations or construction',
          'Extra charges apply for excessive mess or special requests',
          'Clear access needed 2 hours before your session',
          'Professional needs a clean, accessible space to work efficiently',
        ],
      },
      {
        'id': '2',
        'title': 'Furniture Cleaning',
        'subtitle': 'Single - 60 mins (20% off)',
        'duration': '60 min.',
        'description': 'Professional furniture cleaning for upholstery and fabric care.',
        'fullDescription': 'Restore your furniture to its original beauty with professional cleaning.',
        'originalPrice': 250.0,
        'discountedPrice': 200.0,
        'discountPercentage': 20,
        'image': 'lib/assets/images/furniture_cleaning.png',
        'whatsIncluded': [
          'Deep fabric cleaning',
          'Stain removal treatment',
          'Protective coating application',
        ],
        'whatWeBring': [
          'Professional cleaning equipment',
          'Eco-friendly cleaning solutions',
          'Protective covers and tools',
          'Trained specialist for furniture care',
        ],
        'bookingNotes': [
          'Furniture must be accessible',
          'Remove personal items before service',
          'Extra charges for heavily soiled items',
          'Allow 2-3 hours for complete drying',
          'Professional needs clear workspace',
        ],
      },
      {
        'id': '3',
        'title': 'Home Deep Cleaning',
        'subtitle': 'Single - 120 mins (30% off)',
        'duration': '120 min.',
        'description': 'Comprehensive deep cleaning for your entire home.',
        'fullDescription': 'Transform your home with our thorough deep cleaning service.',
        'originalPrice': 400.0,
        'discountedPrice': 280.0,
        'discountPercentage': 30,
        'image': 'lib/assets/images/home_deep_cleaning.webp',
        'whatsIncluded': [
          'Complete room-by-room cleaning',
          'Deep sanitization treatment',
          'Appliance cleaning included',
        ],
        'whatWeBring': [
          'Professional deep cleaning equipment',
          'Hospital-grade disinfectants',
          'Specialized cleaning tools',
          'Trained deep cleaning specialists',
        ],
        'bookingNotes': [
          'Entire home must be accessible',
          'Remove fragile items before service',
          'Extra charges for excessive clutter',
          'Allow 4-6 hours for complete service',
          'Professional team needs clear access to all areas',
        ],
      },
    ];
  }

  // Show service popup
  void showServicePopup(int serviceIndex) {
    selectedServiceIndex.value = serviceIndex;
    isServicePopupVisible.value = true;
  }

  // Hide service popup
  void hideServicePopup() {
    isServicePopupVisible.value = false;
  }

  // Toggle service favorite
  void toggleServiceFavorite() {
    isServiceFavorited.value = !isServiceFavorited.value;
  }

  // Increase service quantity
  void increaseQuantity() {
    serviceQuantity.value++;
  }

  // Decrease service quantity
  void decreaseQuantity() {
    if (serviceQuantity.value > 1) {
      serviceQuantity.value--;
    }
  }

  // Add service to cart
  void addServiceToCart(RxString appBarText) {
    final service = serviceDetails[selectedServiceIndex.value];
    // final totalPrice = service['discountedPrice'] * serviceQuantity.value;
    Get.toNamed(AppRoutes.bookServiceStep1,arguments:appBarText );
    hideServicePopup();
  }

  // Get current service details
  Map<String, dynamic> get currentService {
    if (selectedServiceIndex.value < serviceDetails.length) {
      return serviceDetails[selectedServiceIndex.value];
    }
    return serviceDetails.first;
  }

  // Get formatted price
  String getFormattedPrice(double price) {
    return 'AED ${price.toStringAsFixed(0)}';
  }

  // Get total price for current service
  double get totalServicePrice {
    final service = currentService;
    return service['discountedPrice'] * serviceQuantity.value;
  }
}
