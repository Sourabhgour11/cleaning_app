import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:cleaning_app/app/utils/custom_textformfield.dart';
import 'package:cleaning_app/app/utils/validators.dart';
import 'contact_us_screen_controller.dart';

class ContactUsScreen extends GetView<ContactUsController> {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyle.appBarStyle("Contact Us"),
      body: Obx(() {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppStyle.heightPercent(context, 1)),
                      CustomTextFormField(
                        hintText: "Full Name",
                        controller: controller.nameController,
                        validator: Validators.requiredField,
                        readOnly: true,
                      ),
                      SizedBox(height: AppStyle.heightPercent(context, 2)),
                      CustomTextFormField(
                        hintText: "Email Address",
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                        readOnly: true,
                      ),
                      SizedBox(height: AppStyle.heightPercent(context, 2)),
                      CustomTextFormField(hintText: "Message", controller: controller.messageController,maxLines: 5,validator: Validators.requiredField,),
                      const SizedBox(height: 24),
                      AppButton(onPressed: (){
                        if(controller.formKey.currentState!.validate()){
                      print('Email: ${controller.emailController.text}');
                      controller.sendContactMessageApi();
                        }

                      }, title: controller.isLoading.value
                          ? 'Sending...'
                          : 'Send Message'),
                    ],
                  ),
                ),
              ),
            ),
            if (controller.isLoading.value)
              const Center(child: CircularProgressIndicator(backgroundColor: AppColours.appColor,)),
          ],
        );
      }),
    );
  }
}
