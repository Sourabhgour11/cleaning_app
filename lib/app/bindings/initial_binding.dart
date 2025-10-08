import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ApiService>(() => ApiService());
    // Get.lazyPut<LocalStorage>(() => LocalStorage());
  }
}
