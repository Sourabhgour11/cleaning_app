import 'package:cleaning_app/app/utils/app_export.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColours.appColor,
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
                    AppStrings.signUpToContinue,
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
                                Icons.shield_rounded,
                                color: AppColours.appColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              AppStrings.signUp,
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
                        // Name Field
                        Row(
                          children: [
                            const Icon(
                              Icons.person_outline,
                              color: AppColours.appColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              AppStrings.name,
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
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
                              hintStyle: TextStyle(color: AppColours.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: AppColours.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

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
                        // Phone Field
                        Row(
                          children: [
                            const Icon(
                              Icons.phone_outlined,
                              color: AppColours.appColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              AppStrings.phone,
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
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Enter your phone number',
                              hintStyle: TextStyle(color: AppColours.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: AppColours.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Address Field
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: AppColours.appColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              AppStrings.address,
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
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Enter your address',
                              hintStyle: TextStyle(color: AppColours.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: AppColours.grey,
                                size: 20,
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
                              hintText: 'Enter your confirm password',
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

                        const SizedBox(height: 10),
                        // Password Field
                        Row(
                          children: [
                            const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColours.appColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              AppStrings.confirmPassword,
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
                              hintText: 'Enter your confirm password',
                              hintStyle: TextStyle(color: AppColours.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
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
                        const SizedBox(height: 16),

                        // Sign Up Button
                        Center(
                          child: AppButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.otp);
                            },
                            title: AppStrings.signUp,
                            icon: Icons.login,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppStrings.alreadyHaveAnAccount,
                              style: TextStyle(
                                color: AppColours.grey,
                                fontFamily: AppFonts.fontFamily,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.login);
                              },
                              child: Text(
                                AppStrings.login,
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
