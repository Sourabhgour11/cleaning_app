import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:lottie/lottie.dart';

class PaymentMethod {
  final String id;
  final String name;
  final String icon;
  final List<String> supportedCards;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.supportedCards,
  });
}

class PaymentSummary {
  final double subtotal;
  final double serviceFee;
  final double vat;
  final double total;

  PaymentSummary({
    required this.subtotal,
    required this.serviceFee,
    required this.vat,
    required this.total,
  });
}

class BookServiceStep4ScreenController extends GetxController {
  // Selected payment method
  final RxString selectedPaymentMethodId = 'credit_card'.obs;
  
  // Card details
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController voucherCodeController = TextEditingController();
  
  // Payment summary
  final Rx<PaymentSummary> paymentSummary = PaymentSummary(
    subtotal: 209.0,
    serviceFee: 9.0,
    vat: 0.0,
    total: 218.0,
  ).obs;
  
  // Verification amount
  final RxDouble verificationAmount = 3.67.obs;

  var appBarTitle = "".obs;

  @override
  void onInit() {
    super.onInit();
    appBarTitle.value = Get.arguments.toString();
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    voucherCodeController.dispose();
    super.onClose();
  }

  // Payment methods data
  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: 'credit_card',
      name: 'Credit / Debit Card',
      icon: 'credit_card',
      supportedCards: ['amex', 'mastercard', 'visa'],
    ),
    PaymentMethod(
      id: 'apple_pay',
      name: 'Apple Pay',
      icon: 'apple_pay',
      supportedCards: [],
    ),
    PaymentMethod(
      id: 'google_pay',
      name: 'Google Pay',
      icon: 'google_pay',
      supportedCards: [],
    ),
  ];

  // Select payment method
  void selectPaymentMethod(String paymentMethodId) {
    selectedPaymentMethodId.value = paymentMethodId;
    update();
  }

  // Apply voucher code
  void applyVoucherCode() {
    final code = voucherCodeController.text.trim();
    if (code.isNotEmpty) {
      // TODO: Validate voucher code with API
      Get.snackbar('Success', 'Voucher code applied successfully!');
      // Update payment summary if voucher is valid
    } else {
      Get.snackbar('Error', 'Please enter a voucher code');
    }
  }

  // Format card number
  String formatCardNumber(String value) {
    // Remove all non-digits
    String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    // Add spaces every 4 digits
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }
    
    return formatted;
  }

  // Format expiry date
  String formatExpiryDate(String value) {
    // Remove all non-digits
    String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    // Add slash after 2 digits
    if (digitsOnly.length >= 2) {
      return '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2)}';
    }
    
    return digitsOnly;
  }

  // Validate card details
  bool validateCardDetails() {
    if (cardNumberController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter card number');
      return false;
    }
    
    if (expiryDateController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter expiry date');
      return false;
    }
    
    if (cvvController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter CVV');
      return false;
    }
    
    return true;
  }

  // Process payment
  void processPayment() {
    if (validateCardDetails()) {
      // TODO: Process payment with API
      // Show Lottie success popup
      // showLottiePopup(context);
    }
  }

  // Get selected payment method
  PaymentMethod get selectedPaymentMethod {
    return paymentMethods.firstWhere(
      (method) => method.id == selectedPaymentMethodId.value,
      orElse: () => paymentMethods.first,
    );
  }

  // Get card type icon
  String getCardTypeIcon(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return 'visa';
    } else if (cardNumber.startsWith('5') || cardNumber.startsWith('2')) {
      return 'mastercard';
    } else if (cardNumber.startsWith('3')) {
      return 'amex';
    }
    return 'credit_card';
  }

  void testLottieAsset() {
    // Test if the asset can be loaded
    try {
      Lottie.asset('assets/lottie/success.lottie');
      print('Lottie asset path is correct');
    } catch (e) {
      print('Lottie asset error: $e');
    }
  }

  void showLottiePopup(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 300,
            maxHeight: 400,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie Animation Container
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    color: Colors.grey[50],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.asset('lib/assets/icons/checkMark.gif',),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Success Text
                const Text(
                  'Payment Successful!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColours.black,
                    fontFamily: AppFonts.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                const Text(
                  'Your booking has been confirmed',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: AppFonts.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 24),
                
                // OK Button
                SizedBox(
                  width: double.infinity,
                  height: AppStyle.heightPercent(context, 6),
                  child: AppButton(onPressed: (){
                    Get.toNamed(AppRoutes.userBottomNav);
                  }, title: "OK")
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

}