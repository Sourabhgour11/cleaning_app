import '../../../utils/app_export.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColours.white,
      body: SafeArea(
        child: Container(
          height: height * 100 / 100,
          width: width * 100 / 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 2 / 100),
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1000),
                  tween: Tween(begin: 0.0, end: 1.1),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        width: width * 20 / 100,
                        height: width * 20 / 100,
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
                const SizedBox(height: 20),

                // App Title with Gradient
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColours.appColor, AppColours.black],
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColours.white,
                      fontFamily: AppFonts.fontFamily,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColours.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColours.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    AppStrings.signInToContinue,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColours.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFonts.fontFamily,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Container(
                  width: width * 100 / 100,
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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Text with Icon
                        Row(
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

                        const SizedBox(height: 10),
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
                              AppStrings.email,
                              style: AppStyle.textfieldHeading,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Container(
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
                          child: const TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
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
                        const SizedBox(height: 20),

                        // Password Field
                        Row(
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
                        const SizedBox(height: 10),
                        Container(
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
                          child: const TextField(
                            obscureText: true,
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
                              suffixIcon: Icon(
                                Icons.visibility_off,
                                color: AppColours.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ),

                        // Forgot Password
                        Align(
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

                        // Login Button
                        Center(
                          child: AppButton(
                            onPressed: () {
                               Get.toNamed(AppRoutes.bottomNav);
                            },
                            title: AppStrings.login,
                            icon: Icons.login,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Divider
                        Row(
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
                        const SizedBox(height: 20),

                        // Social Login Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: width * 12 / 100,
                              height: width * 12 / 100,
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
                              width: width * 12 / 100,
                              height: width * 12 / 100,
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
                              width: width * 12 / 100,
                              height: width * 12 / 100,
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
                        const SizedBox(height: 20),

                        // Sign Up Link
                        Row(
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
                                Get.toNamed(AppRoutes.signUp);
                              },
                              child: Text(
                                AppStrings.signUp,
                                style: TextStyle(
                                  color: AppColours.appColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.fontFamily,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
