import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step1/book_service_step1_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'book_service_step4_screen_controller.dart';

class BookServiceStep4Screen extends StatelessWidget {
   BookServiceStep4Screen({super.key});

   final bookServiceStep1Controllerr = Get.find<BookServiceStep1ScreenController>();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookServiceStep4ScreenController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColours.white,
          appBar: AppStyle.appBarStyle(controller.appBarTitle.value),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Payment Method Section
                  _buildPaymentMethodSection(controller),

                  const SizedBox(height: 24),

                  // Card Details Section
                  _buildCardDetailsSection(controller),

                  const SizedBox(height: 24),

                  // Voucher Code Section
                  _buildVoucherCodeSection(controller),

                  const SizedBox(height: 24),

                  // Payment Summary Section
                  _buildPaymentSummarySection(controller),
                  
                  const SizedBox(height: 24),
                  
                  const SizedBox(height: 20), // Space for fixed footer
                ],
              ),
            ),
          ),

          // Fixed footer
          bottomNavigationBar: _buildFooter(controller,context,bookServiceStep1Controllerr),
        );
      },
    );
  }

  Widget _buildPaymentMethodSection(
    BookServiceStep4ScreenController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColours.black,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: AppColours.appColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: AppColours.white,
                    size: 12,
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                // TODO: Show payment method selection
              },
              child: const Text(
                'Change',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColours.appColor,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Selected Payment Method Card
        _buildPaymentMethodCard(controller),
      ],
    );
  }

  Widget _buildPaymentMethodCard(BookServiceStep4ScreenController controller) {
    final selectedMethod = controller.selectedPaymentMethod;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.appColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColours.appColor, width: 1),
      ),
      child: Row(
        children: [
          // Credit card icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColours.appColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.credit_card,
              color: AppColours.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          // Payment method name
          Expanded(
            child: Text(
              selectedMethod.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColours.black,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ),

          // Card type icons
          Row(
            children: [
              _buildCardTypeIcon('amex'),
              const SizedBox(width: 8),
              _buildCardTypeIcon('mastercard'),
              const SizedBox(width: 8),
              _buildCardTypeIcon('visa'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardTypeIcon(String cardType) {
    IconData iconData;
    Color color;

    switch (cardType) {
      case 'amex':
        iconData = Icons.credit_card;
        color = Colors.blue;
        break;
      case 'mastercard':
        iconData = Icons.credit_card;
        color = Colors.red;
        break;
      case 'visa':
        iconData = Icons.credit_card;
        color = Colors.blue;
        break;
      default:
        iconData = Icons.credit_card;
        color = Colors.grey;
    }

    return Container(
      width: 24,
      height: 16,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 1),
      ),
      child: Icon(iconData, color: color, size: 12),
    );
  }

  Widget _buildCardDetailsSection(BookServiceStep4ScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card Number
        _buildInputField(
          controller: controller.cardNumberController,
          label: 'Card Number',
          hintText: '1234 5678 9012 3456',
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final formatted = controller.formatCardNumber(value);
            if (formatted != value) {
              controller.cardNumberController.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.collapsed(offset: formatted.length),
              );
            }
          },
        ),

        const SizedBox(height: 16),

        // Expiry Date and CVV
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                controller: controller.expiryDateController,
                label: 'Exp. Date (MM/YY)',
                hintText: '12/25',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final formatted = controller.formatExpiryDate(value);
                  if (formatted != value) {
                    controller.expiryDateController.value = TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(
                        offset: formatted.length,
                      ),
                    );
                  }
                },
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: _buildInputField(
                controller: controller.cvvController,
                label: 'CVV Number',
                hintText: '123',
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Verification amount info
        _buildInfoBox(
          icon: Icons.refresh,
          text:
              'AED ${controller.verificationAmount.value.toStringAsFixed(2)} will be charged to verify your card. The amount will be refunded immediately.',
        ),

        const SizedBox(height: 12),

        // Session amount info
        _buildInfoBox(
          icon: Icons.info_outline,
          text:
              'The session amount will be reserved on your card. You will be charged once the session is completed.',
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontFamily: AppFonts.fontFamily,
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColours.appColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColours.appColor, size: 16),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherCodeSection(BookServiceStep4ScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Voucher Code',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),

        const SizedBox(height: 16),

        // Voucher code input
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.voucherCodeController,
                decoration: InputDecoration(
                  hintText: 'Voucher Code',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontFamily: AppFonts.fontFamily,
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColours.appColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Add button
            GestureDetector(
              onTap: controller.applyVoucherCode,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColours.appColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Add +',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColours.white,
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentSummarySection(
    BookServiceStep4ScreenController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),

        const SizedBox(height: 16),

        // Summary items
        Obx(
          () => Column(
            children: [
              _buildSummaryRow(
                'Subtotal',
                'AED ${controller.paymentSummary.value.subtotal.toStringAsFixed(2)}',
              ),

              const SizedBox(height: 12),

              _buildSummaryRow(
                'Service Fee',
                'AED ${controller.paymentSummary.value.serviceFee.toStringAsFixed(2)}',
                showInfo: true,
              ),

              const SizedBox(height: 12),

              _buildSummaryRow(
                'Total (inc. VAT)',
                'AED ${controller.paymentSummary.value.total.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    String amount, {
    bool showInfo = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (showInfo) ...[
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: AppColours.appColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: AppColours.white,
                  size: 10,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
                color: AppColours.black,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ],
        ),

        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(
    BookServiceStep4ScreenController controller,
    BuildContext context,
    BookServiceStep1ScreenController bookServiceController,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Total section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Obx(
                      () => Text(
                        'AED ${controller.verificationAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        bookServiceController.showBookingSummaryBottomSheet(
                          context,
                        );
                      },
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Next button
          SizedBox(
            height: AppStyle.heightPercent(context, 5),
            width: AppStyle.widthPercent(context, 30),
            child: AppButton(
              onPressed: () {
                controller.showLottiePopup(context);
              },
              title: "Next",
            ),
          ),
        ],
      ),
    );
  }
}
