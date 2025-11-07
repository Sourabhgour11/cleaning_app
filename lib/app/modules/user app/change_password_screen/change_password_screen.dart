import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:cleaning_app/app/utils/custom_textformfield.dart';
import 'package:cleaning_app/app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'change_password_screen_controller.dart';


class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: AppStyle.appBarStyle("Change Password"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              // Old Password
              CustomTextFormField(hintText: "Confirm Old Password",
                  controller: controller.oldPasswordController,validator: Validators.requiredField,),
              SizedBox(height: AppStyle.heightPercent(context, 2)),

              // New Password
              CustomTextFormField(hintText: "Create New Password",
                controller: controller.newPasswordController,
                isPassword: true,
                obscureText: true,),
              SizedBox(height: AppStyle.heightPercent(context, 2)),

              // Confirm New Password
              CustomTextFormField(hintText: "Confirm New Password",
                controller: controller.confirmPasswordController,
                isConfirmPassword: true,
                obscureText: true,
                confirmWithController
                :controller.newPasswordController,
              ),
              SizedBox(height: AppStyle.heightPercent(context, 2.5)),

              AppButton(onPressed: () {
                if(controller.formKey.currentState!.validate()){
                  controller.changePasswordApi();
                }

              }, title: "Change Password")
            ],
          ),
        ),
      ),
    );
  }
}
