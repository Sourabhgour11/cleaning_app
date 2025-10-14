import '../../../utils/app_export.dart';
import 'login_screen_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginScreenController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: AppStyle.heightPercent(context, 5)),

                  // Back Button
                  Row(
                    children: [
                      SizedBox(width: AppStyle.widthPercent(context, 5)),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: AppStyle.widthPercent(context, 8),
                          height: AppStyle.widthPercent(context, 8),
                          decoration: BoxDecoration(
                            color: AppColours.white.withOpacity(0.95),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColours.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColours.black,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppStyle.heightPercent(context, 3)),
                  // Logo + Title (fixed)
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1000),
                    tween: Tween(begin: 0.0, end: 1.1),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          width: AppStyle.widthPercent(context, 18),
                          height: AppStyle.widthPercent(context, 18),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColours.white,
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
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColours.appColor, AppColours.black],
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      AppStrings.appName,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColours.white,
                      ),
                    ),
                  ),
                ],
              ),

              // 🔹 Bottom Form (scrollable with keyboard)
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
                    height: AppStyle.heightPercent(context, 65),
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
                          SizedBox(
                            width: AppStyle.widthPercent(context, 70),
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
                                    Icons.waving_hand,
                                    color: AppColours.appColor,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  AppStrings.welcomeBack,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: AppColours.appColor,
                                    fontFamily: AppFonts.fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: AppStyle.heightPercent(context, 2)),
                          // Email Field
                          SizedBox(
                            width: AppStyle.widthPercent(context, 90),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  color: AppColours.appColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  AppStrings.email,
                                  style: AppStyle.textfieldHeading,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),
                          Container(
                            width: AppStyle.widthPercent(context, 90),
                            decoration: BoxDecoration(
                              color: AppColours.white,
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
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.emailController,
                              decoration: const InputDecoration(
                                hintText: 'Enter your email address',
                                hintStyle: TextStyle(color: AppColours.grey),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: AppColours.grey,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),

                          // Password Field
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
                                  AppStrings.password,
                                  style: AppStyle.textfieldHeading,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),
                          Container(
                            width: AppStyle.widthPercent(context, 90),
                            decoration: BoxDecoration(
                              color: AppColours.white,
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
                                controller: controller.passwordController,
                                obscureText: controller.isPasswordVisible.value,
                                decoration: InputDecoration(
                                  hintText: 'Enter your password',
                                  hintStyle: TextStyle(color: AppColours.grey),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: AppColours.grey,
                                    size: 20,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.togglePasswordVisibility(
                                        controller.passwordController,
                                      );
                                    },
                                    icon: Icon(
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColours.grey,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Forgot Password
                          SizedBox(
                            width: AppStyle.widthPercent(context, 90),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.forgotPassword);
                                },
                                child: Text(
                                  AppStrings.forgotPassword,
                                  style: TextStyle(
                                    color: AppColours.appColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily: AppFonts.fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Login Button
                          SizedBox(
                            width: AppStyle.widthPercent(context, 90),
                            child: AppButton(
                              onPressed: () {
                                controller.login(
                                  controller.emailController.text,
                                  controller.passwordController.text,
                                );
                              },
                              title: AppStrings.login,
                              icon: Icons.login,
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),

                          // Divider
                          SizedBox(
                            width: AppStyle.widthPercent(context, 90),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: AppColours.grey.withOpacity(0.3),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    AppStrings.or,
                                    style: TextStyle(
                                      color: AppColours.grey,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.fontFamily,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: AppColours.grey.withOpacity(0.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),

                          // Social Login Buttons
                          SizedBox(
                            width: AppStyle.widthPercent(context, 90),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: AppStyle.widthPercent(context, 12),
                                  height: AppStyle.widthPercent(context, 12),
                                  decoration: BoxDecoration(
                                    color: AppColours.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColours.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColours.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.g_mobiledata,
                                    color: Colors.red,
                                    size: 28,
                                  ),
                                ),
                                Container(
                                  width: AppStyle.widthPercent(context, 12),
                                  height: AppStyle.widthPercent(context, 12),
                                  decoration: BoxDecoration(
                                    color: AppColours.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColours.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColours.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.facebook,
                                    color: Colors.blue,
                                    size: 28,
                                  ),
                                ),
                                Container(
                                  width: AppStyle.widthPercent(context, 12),
                                  height: AppStyle.widthPercent(context, 12),
                                  decoration: BoxDecoration(
                                    color: AppColours.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColours.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColours.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.apple,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),

                          // Sign Up Link
                          SizedBox(
                            width: AppStyle.widthPercent(context, 90),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  AppStrings.dontHaveAnAccount,
                                  style: TextStyle(
                                    color: AppColours.grey,
                                    fontFamily: AppFonts.fontFamily,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes.signUp,
                                      arguments: controller.userType,
                                    );
                                  },
                                  child: Text(
                                    AppStrings.signUp,
                                    style: TextStyle(
                                      color: AppColours.appColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFonts.fontFamily,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColours.appColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppStyle.heightPercent(context, 2)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
