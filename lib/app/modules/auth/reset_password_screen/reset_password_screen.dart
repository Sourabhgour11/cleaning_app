import '../../../utils/app_export.dart';
import 'reset_password_screen_controller.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final controller = Get.put(ResetPasswordScreenController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColours.appColor,
        resizeToAvoidBottomInset: false,
        body: Container(
          height: AppStyle.heightPercent(context, 100),
          width: AppStyle.widthPercent(context, 100),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Column(
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
                  SizedBox(height: AppStyle.heightPercent(context, 2)),
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
                  SizedBox(height: AppStyle.heightPercent(context, 1)),

                  // Title with Gradient
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColours.appColor, AppColours.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      AppStrings.resetPassword,
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
                      AppStrings.createANewPasswordForYourAccount,
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
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedPadding(
                  // 👇 this listens for keyboard open/close
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  child: Container(
                    width: AppStyle.widthPercent(context, 100),
                    height: AppStyle.heightPercent(context, 55),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColours.white, Color(0xFFF8F9FA)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColours.appColor.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                        BoxShadow(
                          color: AppColours.black.withOpacity(0.7),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: AppStyle.heightPercent(context, 2)),

                          // Form Title
                          SizedBox(
                            width: AppStyle.widthPercent(context, 80),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                  AppStrings.createNewPassword,
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
                          SizedBox(height: AppStyle.heightPercent(context, 3)),

                          // New Password Field
                          SizedBox(
                            width: AppStyle.widthPercent(context, 90),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.lock_outline,
                                  color: AppColours.appColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  AppStrings.newPassword,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColours.black,
                                    fontFamily: AppFonts.fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),
                          Container(
                            width: AppStyle.widthPercent(context, 90),
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
                            child: Obx(
                              () => TextField(
                                controller:
                                    controller.newPasswordController.value,
                                focusNode: controller.newPasswordFocusNode,
                                obscureText:
                                    !controller.isNewPasswordVisible.value,
                                decoration: InputDecoration(
                                  hintText: 'Enter new password',
                                  hintStyle: const TextStyle(
                                    color: AppColours.grey,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: AppColours.grey,
                                    size: 20,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isNewPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColours.grey,
                                      size: 20,
                                    ),
                                    onPressed:
                                        controller.toggleNewPasswordVisibility,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),

                          // Confirm Password Field
                          SizedBox(
                            width: AppStyle.widthPercent(context, 90),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.lock_outline,
                                  color: AppColours.appColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  AppStrings.confirmPassword,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColours.black,
                                    fontFamily: AppFonts.fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),
                          Container(
                            width: AppStyle.widthPercent(context, 90),
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
                            child: Obx(
                              () => TextField(
                                controller:
                                    controller.confirmPasswordController.value,
                                focusNode: controller.confirmPasswordFocusNode,
                                obscureText:
                                    !controller.isConfirmPasswordVisible.value,
                                decoration: InputDecoration(
                                  hintText: 'Confirm new password',
                                  hintStyle: const TextStyle(
                                    color: AppColours.grey,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: AppColours.grey,
                                    size: 20,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isConfirmPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColours.grey,
                                      size: 20,
                                    ),
                                    onPressed: controller
                                        .toggleConfirmPasswordVisibility,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 3)),

                          // Password Requirements
                          Container(
                            width: AppStyle.widthPercent(context, 90),
                            decoration: BoxDecoration(
                              color: AppColours.appColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColours.appColor.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: AppStyle.heightPercent(context, 2),
                                ),
                                SizedBox(
                                  width: AppStyle.widthPercent(context, 80),
                                  child: const Text(
                                    AppStrings.passwordRequirements,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColours.appColor,
                                      fontFamily: AppFonts.fontFamily,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppStyle.heightPercent(context, 1),
                                ),
                                SizedBox(
                                  width: AppStyle.widthPercent(context, 80),
                                  child: const Text(
                                    '• At least 8 characters long\n• Contains uppercase and lowercase letters\n• Contains at least one number\n• Contains at least one special character',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColours.grey,
                                      fontFamily: AppFonts.fontFamily,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppStyle.heightPercent(context, 2),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 3)),

                          // Reset Password Button
                          SizedBox(
                            width: AppStyle.widthPercent(context, 90),
                            child: AppButton(
                              onPressed: controller.isLoading.value
                                  ? () {
                                      Get.toNamed(AppRoutes.login);
                                    }
                                  : controller.resetPassword,
                              title: AppStrings.resetPassword,
                              icon: Icons.check_circle,
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),

                          // Back to Login
                          SizedBox(
                            width: AppStyle.widthPercent(context, 90),
                            child: Row(
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
                                    Get.toNamed(AppRoutes.login);
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
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 4)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
