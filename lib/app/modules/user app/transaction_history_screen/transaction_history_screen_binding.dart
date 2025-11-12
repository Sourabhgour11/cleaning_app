import 'package:cleaning_app/app/modules/user%20app/transaction_history_screen/transaction_history_screen_controller.dart';
import 'package:get/get.dart';


class TransactionHistoryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionHistoryScreenController>(() => TransactionHistoryScreenController());
  }
}
