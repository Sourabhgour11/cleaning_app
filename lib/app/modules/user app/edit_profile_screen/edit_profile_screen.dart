import 'dart:io';

import 'package:cleaning_app/app/utils/app_camera_popup.dart';
import 'package:cleaning_app/app/utils/place_search_widget.dart';

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
      appBar: AppStyle.appBarStyle(AppStrings.editProfile),
      body: SafeArea(
        child: SizedBox(
          width: AppStyle.widthPercent(context, 100),
          height: AppStyle.heightPercent(context, 100),
          child: Column(
            children: [Expanded(child: _buildBody(context, height, width))],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, double height, double width) {
    return Container(
      width: AppStyle.widthPercent(context, 90),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColours.white, Color(0xFFF8F9FA)],
        ),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          width: AppStyle.widthPercent(context, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppStyle.heightPercent(context, 2)),
              _buildProfileImage(context),
              SizedBox(height: AppStyle.heightPercent(context, 3)),
              _buildNameField(),
              SizedBox(height: AppStyle.heightPercent(context, 2)),
              _buildEmailField(),
              SizedBox(height: AppStyle.heightPercent(context, 2)),
              _buildPhoneField(),
              SizedBox(height: AppStyle.heightPercent(context, 2)),
              _buildAddressField(),
              SizedBox(height: AppStyle.heightPercent(context, 2)),
              _buildUpdateButton(context),
              SizedBox(height: AppStyle.heightPercent(context, 2)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Obx(() {
            final File? image = controller.selectedImage.value;
            return CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: image != null ? FileImage(image) : null,
              child: image == null
                  ? Icon(Icons.person, color: Colors.grey[400], size: 70)
                  : null,
            );
          }),

          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => controller.pickImage(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColours.appColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColours.white, width: 3),
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
            const Text(AppStrings.name, style: AppStyle.textfieldHeading),
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
              prefixIcon: Icon(Icons.person, color: AppColours.grey, size: 20),
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
            const Text(AppStrings.email, style: AppStyle.textfieldHeading),
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
              prefixIcon: Icon(Icons.email, color: AppColours.grey, size: 20),
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
            const Text(AppStrings.phone, style: AppStyle.textfieldHeading),
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
              prefixIcon: Icon(Icons.phone, color: AppColours.grey, size: 20),
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
            const Text(AppStrings.address, style: AppStyle.textfieldHeading),
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
          child: PlaceSearchWidget(),
        ),
      ],
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return SizedBox(
      width: AppStyle.widthPercent(context, 90),
      child: Center(
        child: Obx(
          () => controller.isLoading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColours.appColor,
                  ),
                )
              : AppButton(
                  onPressed: () => controller.updateProfile(),
                  title: 'Update Profile',
                  icon: Icons.check_circle,
                ),
        ),
      ),
    );
  }
}
