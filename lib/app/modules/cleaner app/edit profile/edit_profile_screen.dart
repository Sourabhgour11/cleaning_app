import '../../../utils/app_export.dart';
import 'edit_profile_screen_controller.dart';

class EditProfileScreen extends GetView<EditProfileScreenController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppStyle.appBarStyle("Edit Profile"),
      body: SafeArea(
        child: Column(
          children: [
              Expanded(
                child: _buildBody(context, height, width),
              ),
          ],
          ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, double height, double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColours.white, Color(0xFFF8F9FA)],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildProfileImage(),
            const SizedBox(height: 30),
            _buildNameField(),
            const SizedBox(height: 20),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPhoneField(),
            const SizedBox(height: 20),
            _buildAddressField(),
            const SizedBox(height: 20),
            // _buildPasswordField(),
            // const SizedBox(height: 20),
            // _buildConfirmPasswordField(),
            // const SizedBox(height: 30),
            _buildUpdateButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          Obx(
            () => Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColours.white,
                border: Border.all(
                  color: AppColours.appColor,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColours.appColor.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  controller.profileImage.value,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => controller.pickImage(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColours.appColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColours.white,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColours.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: AppColours.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          child: TextField(
            controller: controller.nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
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
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          child: TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
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
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          child: TextField(
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
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
      ],
    );
  }

  Widget _buildAddressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          child: TextField(
            controller: controller.addressController,
            keyboardType: TextInputType.text,
            maxLines: 2,
            decoration: const InputDecoration(
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
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            const SizedBox(width: 5),
            const Text(
              '(Optional)',
              style: TextStyle(
                color: AppColours.grey,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Obx(
          () => Container(
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
              controller: controller.passwordController,
              obscureText: !controller.isPasswordVisible.value,
              decoration: InputDecoration(
                hintText: 'Enter new password',
                hintStyle: const TextStyle(color: AppColours.grey),
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
                suffixIcon: GestureDetector(
                  onTap: () => controller.togglePasswordVisibility(),
                  child: Icon(
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
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            const SizedBox(width: 5),
            const Text(
              '(Optional)',
              style: TextStyle(
                color: AppColours.grey,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Obx(
          () => Container(
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
              controller: controller.confirmPasswordController,
              obscureText: !controller.isConfirmPasswordVisible.value,
              decoration: InputDecoration(
                hintText: 'Confirm new password',
                hintStyle: const TextStyle(color: AppColours.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: AppColours.grey,
                  size: 20,
                ),
                suffixIcon: GestureDetector(
                  onTap: () => controller.toggleConfirmPasswordVisibility(),
                  child: Icon(
                    controller.isConfirmPasswordVisible.value
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
      ],
    );
  }

  Widget _buildUpdateButton() {
    return Center(
      child: Obx(
        () => controller.isLoading.value
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColours.appColor),
              )
            : AppButton(
                onPressed: () => controller.updateProfile(),
                title: 'Update Profile',
                icon: Icons.check_circle,
              ),
      ),
    );
  }
}