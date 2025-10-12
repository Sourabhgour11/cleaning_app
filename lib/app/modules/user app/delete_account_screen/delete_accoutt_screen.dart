import 'package:cleaning_app/app/modules/user%20app/delete_account_screen/delete_account_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});

  final DeleteAccountScreenController controller = Get.put(DeleteAccountScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyle.appBarStyle("Delete Account"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 6),
            Obx(() => Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                controller.userEmail.value,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            )),
            const SizedBox(height: 24),

            const Text(
              'Reason for deleting account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: controller.reasonController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Please tell us why you want to delete your account...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.redAccent, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Spacer(),

            // Delete Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.confirmDelete,
                icon: const Icon(Icons.delete_forever, color: Colors.white),
                label: const Text(
                  'Delete Account',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
