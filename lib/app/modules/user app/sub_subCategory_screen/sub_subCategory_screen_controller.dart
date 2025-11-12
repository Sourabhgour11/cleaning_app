
import 'package:cleaning_app/app/modules/user%20app/sub_subCategory_screen/sub_subCategory_model.dart';
import 'package:get/get.dart';

class SubSubCategoryController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<SubSubCategoryModel> subSubCategories = <SubSubCategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubSubCategories();
  }

  void fetchSubSubCategories() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate API delay

    // Mock data – you can load from API later
    subSubCategories.value = [
      SubSubCategoryModel(
        name: 'Kitchen Deep Cleaning',
        image:
        'https://images.unsplash.com/photo-1616486702323-9c94e7a744b3?auto=format&fit=crop&w=600&q=60',
        description: 'Thorough cleaning of kitchen, chimney & cabinets.',
        price: 1499,
      ),
      SubSubCategoryModel(
        name: 'Bathroom Deep Cleaning',
        image:
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=600&q=60',
        description: 'Tiles, fittings & sanitization for complete hygiene.',
        price: 899,
      ),
      SubSubCategoryModel(
        name: 'Living Room Deep Cleaning',
        image:
        'https://images.unsplash.com/photo-1600585153837-0c64f3e4b40e?auto=format&fit=crop&w=600&q=60',
        description: 'Vacuuming, dusting & polishing your living area.',
        price: 1299,
      ),
      SubSubCategoryModel(
        name: 'Carpet & Sofa Shampooing',
        image:
        'https://images.unsplash.com/photo-1581578731548-c64695cc6952?auto=format&fit=crop&w=600&q=60',
        description: 'Deep shampoo cleaning for carpet & sofa.',
        price: 1599,
      ),
    ];

    isLoading.value = false;
  }

  String getFormattedPrice(num price) => "₹${price.toStringAsFixed(0)}";
}