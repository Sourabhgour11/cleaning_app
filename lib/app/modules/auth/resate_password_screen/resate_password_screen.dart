import '../../../utils/app_export.dart';
import 'resate_password_screen_controller.dart';

class ResatePasswordScreen extends StatelessWidget {
  ResatePasswordScreen({super.key});
  final controller = Get.put(ResatePasswordScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.appColor,
      body: SafeArea(
        child: Container(
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

                // Back Button
                Row(
                  children: [
                    SizedBox(width: AppStyle.widthPercent(context, 5)),
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 800),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: 45,
                              height: 45,
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
                                  color: AppColours.appColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: AppStyle.heightPercent(context, 8)),

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
                SizedBox(height: AppStyle.heightPercent(context, 4)),

                // Title with Gradient
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColours.appColor, AppColours.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    'Reset Password',
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
                    'Create a new password for your account',
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
                  padding: const EdgeInsets.all(30),
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
                            'Create New Password',
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

                      // New Password Field
                      Row(
                        children: [
                          const Icon(
                            Icons.lock_outline,
                            color: AppColours.appColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'New Password',
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
                        child: Obx(
                          () => TextField(
                            controller: controller.newPasswordController.value,
                            focusNode: controller.newPasswordFocusNode,
                            obscureText: !controller.isNewPasswordVisible.value,
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
                      const SizedBox(height: 20),

                      // Confirm Password Field
                      Row(
                        children: [
                          const Icon(
                            Icons.lock_outline,
                            color: AppColours.appColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Confirm Password',
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
                                onPressed:
                                    controller.toggleConfirmPasswordVisibility,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Password Requirements
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColours.appColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColours.appColor.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Password Requirements:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColours.appColor,
                                fontFamily: AppFonts.fontFamily,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '• At least 8 characters long\n• Contains uppercase and lowercase letters\n• Contains at least one number\n• Contains at least one special character',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColours.grey,
                                fontFamily: AppFonts.fontFamily,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Reset Password Button
                      Center(
                        child: AppButton(
                          onPressed: controller.isLoading.value
                              ? () {
                                  Get.toNamed(AppRoutes.login);
                                }
                              : controller.resetPassword,
                          title: 'Reset Password',
                          icon: Icons.check_circle,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Back to Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Remember your password? ",
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
                              'Back to Login',
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
                SizedBox(height: AppStyle.heightPercent(context, 4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
