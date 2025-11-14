import 'package:cleaning_app/app/data/models/get_sub_sub_category_model.dart';
import 'package:cleaning_app/app/utils/app_export.dart';

class ServiceDetailsScreenController extends GetxController {

  late CategoryArray item;


  @override
  void onInit() {
    super.onInit();
    // Get the passed argument (the CategoryArr instance)
    item = Get.arguments;
    print("${item.name}");
  }


}