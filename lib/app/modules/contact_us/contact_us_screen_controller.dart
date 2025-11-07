import 'package:cleaning_app/app/utils/app_constants.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:cleaning_app/app/utils/app_local_storage.dart';
import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';


class ContactUsController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  var userDetails = AppLocalStorage.getUserDetails();

  // final userDetails = userDetails?['name'] ?? '';
  // final userEmail = userDetails?['email'] ?? '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController.text = userDetails?['name'] ?? '';
    emailController.text = userDetails?['email'] ?? '';
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: AppUrl.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );

  Future<void> sendContactMessageApi() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    // --- Validation ---
    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    isLoading(true);

    try {
      String? rawToken = AppLocalStorage.getToken();
      String? userId = AppLocalStorage.getUserId();

      // String? rawToken = AppLocalStorage.getToken();

      if (rawToken == null || rawToken.isEmpty) {
        Get.snackbar('Error', 'Token not found. Please login again.');
        isLoading(false);
        return;
      }

      String token = rawToken.startsWith('Bearer ') ? rawToken : 'Bearer $rawToken';

      // ✅ Build data exactly like Postman body
      // final body = [
      //   {"key": "name", "value": name, "type": "text"},
      //   {"key": "email", "value": email, "type": "text"},
      //   {"key": "msgBody", "value": message, "type": "text"},
      // ];

      final response = await dio.post(
        AppUrl.contactUs,
        data: {
          'user_id': userId,
          'name': name,
          'email': email,
          'msgBody': message,
          'user_type': AppConstants.userType,
        },
        options: Options(headers: {
          'Authorization': token,
          'Accept': 'application/json',
        }),
      );

      print('📩 RESPONSE: ${response.data}');

      final rawMsg = response.data['msg'];
      final rawMessage = response.data['errors'];
      final msg = (rawMsg is List) ? rawMsg.join(', ') : rawMsg?.toString() ?? 'Message sent successfully!';
      final errorMessage = (rawMessage is List) ? rawMessage.join(', ') : rawMessage?.toString() ?? 'Validation failed!';

      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.back();
        Get.snackbar('Success', msg);
        clearFields();
      } else {
        Get.snackbar('Error', errorMessage);
      }
    } on DioException catch (e) {
      print('❌ DIO ERROR: ${e.response?.data}');
      String message = 'Failed to send message';
      final data = e.response?.data;
      if (data is Map && data.containsKey('msg')) {
        final msg = data['msg'];
        message = (msg is List) ? msg.join(', ') : msg.toString();
      }
      Get.snackbar('Error', message);
    } catch (e) {
      print('❌ Unexpected error: $e');
      Get.snackbar('Error', 'Unexpected error occurred');
    } finally {
      isLoading(false);
    }
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    messageController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
