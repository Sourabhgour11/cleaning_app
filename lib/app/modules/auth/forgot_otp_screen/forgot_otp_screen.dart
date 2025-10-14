import 'package:pinput/pinput.dart';
import 'package:timer_button/timer_button.dart';
import 'forgot_otp_screen_controller.dart';
import '../../../utils/app_export.dart';

class ForgotOtpScreen extends StatelessWidget {
  ForgotOtpScreen({super.key});
  final controller = Get.put(ForgotOtpScreenController());
  @override
  Widget build(BuildContext context) {
    // Custom pin theme
    final defaultPinTheme = PinTheme(
      width: AppStyle.widthPercent(context, 13),
      height: AppStyle.widthPercent(context, 13),
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColours.black,
      ),
      decoration: BoxDecoration(
        color: AppColours.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColours.grey.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColours.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColours.appColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColours.appColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColours.appColor.withOpacity(0.1),
        border: Border.all(color: AppColours.appColor, width: 2),
      ),
    );

    return Scaffold(
      backgroundColor: AppColours.appColor,
      body: Container(
        height: AppStyle.heightPercent(context, 100),
        width: AppStyle.widthPercent(context, 100),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: AppStyle.heightPercent(context, 3)),
              Row(
                children: [
                  SizedBox(width: AppStyle.widthPercent(context, 5)),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: AppStyle.widthPercent(context, 8),
                      height: AppStyle.heightPercent(context, 8),
                      decoration: BoxDecoration(
                        color: AppColours.white.withOpacity(0.95),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColours.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                          BoxShadow(
                            color: AppColours.appColor.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: AppColours.appColor.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColours.black,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppStyle.heightPercent(context, 3)),
              // App Logo with Animation
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 1000),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: AppStyle.widthPercent(context, 25),
                      height: AppStyle.widthPercent(context, 25),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColours.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColours.appColor.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: AppColours.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AppImages.appLogo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: AppStyle.heightPercent(context, 3)),

              // App Title with Gradient
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppColours.appColor, AppColours.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  AppStrings.verifyOtp,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColours.white,
                    fontFamily: AppFonts.fontFamily,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(height: AppStyle.heightPercent(context, 2)),

              Container(
                width: AppStyle.widthPercent(context, 80),
                height: AppStyle.heightPercent(context, 5),
                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: AppColours.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: AppColours.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Text(
                  AppStrings.enterThe6DigitCodeSentToYourPhone,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColours.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppStyle.heightPercent(context, 5)),

              // OTP Input Container
              Container(
                width: AppStyle.widthPercent(context, 90),
                height: AppStyle.heightPercent(context, 40),
                decoration: BoxDecoration(
                  color: AppColours.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColours.appColor.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                    BoxShadow(
                      color: AppColours.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: AppStyle.heightPercent(context, 2)),
                    // OTP Title
                    SizedBox(
                      width: AppStyle.widthPercent(context, 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColours.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.security,
                              color: AppColours.appColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            AppStrings.enterVerificationCode,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColours.black,
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppStyle.heightPercent(context, 4)),

                    // OTP Pin Input
                    SizedBox(
                      width: AppStyle.widthPercent(context, 80),
                      child: Pinput(
                        length: 6,
                        controller: controller.otpController.value,
                        keyboardType: TextInputType.number,
                        focusNode: controller.otpFocusNode,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => () {},
                        onChanged: (value) {
                          if (value.length == 6) {
                            Get.toNamed(AppRoutes.resatePassword);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: AppStyle.heightPercent(context, 4)),

                    // Verify Button
                    SizedBox(
                      width: AppStyle.widthPercent(context, 80),

                      child: AppButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.resatePassword);
                        },
                        title: AppStrings.verifyOtp,
                        icon: Icons.verified_user,
                      ),
                    ),

                    // Resend OTP
                    SizedBox(
                      width: AppStyle.widthPercent(context, 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            AppStrings.didntReceiveCode,
                            style: TextStyle(
                              color: AppColours.white,
                              fontSize: 14,
                              fontFamily: AppFonts.fontFamily,
                            ),
                          ),
                          TimerButton(
                            label: AppStrings.resend,
                            buttonType: ButtonType.textButton,
                            color: Colors.transparent,
                            disabledColor: Colors.transparent,
                            activeTextStyle: const TextStyle(
                              color: AppColours.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              fontFamily: AppFonts.fontFamily,
                              decorationStyle: TextDecorationStyle.solid,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColours.white,
                            ),
                            disabledTextStyle: const TextStyle(
                              color: AppColours.white,
                            ),
                            timeOutInSeconds: 30,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
