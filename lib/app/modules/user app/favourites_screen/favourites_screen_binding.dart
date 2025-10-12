import 'package:get/get.dart';

import 'favourites_screen_controller.dart';

class FavouritesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouritesScreenController>(() => FavouritesScreenController());
  }
}
