import 'package:cleaning_app/app/modules/user%20app/delete_account_screen/delete_account_screen_controller.dart';
import 'package:get/get.dart';

class DeleteAccountScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeleteAccountScreenController>(() => DeleteAccountScreenController());
  }
}
