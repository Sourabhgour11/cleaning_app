import 'package:cleaning_app/app/modules/user%20app/sub_subCategory_screen/sub_subCategory_screen_controller.dart';
import 'package:get/get.dart';

class SubSubCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubSubCategoryController>(() => SubSubCategoryController());
  }
}
