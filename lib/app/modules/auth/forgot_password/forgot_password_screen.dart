import '../../../utils/app_export.dart';
import 'forgot_password_screen_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final controller = Get.put(ForgotPasswordScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
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
              SizedBox(height: AppStyle.heightPercent(context, 2)),
              Row(
                children: [
                  SizedBox(width: AppStyle.widthPercent(context, 5)),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: AppStyle.widthPercent(context, 10),
                      height: AppStyle.heightPercent(context, 10),
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

              // App Logo with Animation
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 1000),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: 100,
                      height: 100,
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
              SizedBox(height: AppStyle.heightPercent(context, 2)),

              // Title with Gradient
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppColours.appColor, AppColours.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  AppStrings.forgotPassword,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColours.white,
                    fontFamily: AppFonts.fontFamily,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(height: AppStyle.heightPercent(context, 2)),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColours.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: AppColours.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Text(
                  AppStrings.enterEmailToReceiveResetInstructions,
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

              // Main Form Container
              Container(
                width: AppStyle.widthPercent(context, 90),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColours.white.withOpacity(0.95),
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
                  children: [
                    // Form Title
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColours.appColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.lock_reset,
                            color: AppColours.appColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          AppStrings.resetYourPassword,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColours.black,
                            fontFamily: AppFonts.fontFamily,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Email Field
                    Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          color: AppColours.appColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          AppStrings.emailAddress,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColours.black,
                            fontFamily: AppFonts.fontFamily,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColours.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColours.grey.withOpacity(0.2),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColours.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: controller.emailController.value,
                        focusNode: controller.emailFocusNode,

                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: AppStrings.enterYourEmailAddress,
                          hintStyle: const TextStyle(color: AppColours.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: AppColours.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Send Reset Email Button
                    Center(
                      child: AppButton(
                        onPressed: controller.isLoading.value
                            ? () {}
                            : controller.sendResetEmail,
                        title: AppStrings.sendResetEmail,
                        icon: Icons.send,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Back to Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppStrings.rememberYourPassword,
                          style: TextStyle(
                            color: AppColours.grey,
                            fontSize: 14,
                            fontFamily: AppFonts.fontFamily,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            AppStrings.backToLogin,
                            style: TextStyle(
                              color: AppColours.appColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: AppFonts.fontFamily,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColours.appColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppStyle.heightPercent(context, 2)),
            ],
          ),
        ),
      ),
    );
  }
}
