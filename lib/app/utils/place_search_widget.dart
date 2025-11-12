import 'package:cleaning_app/app/modules/auth/sign_up_screen/sign_up_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'map_controller.dart';

class PlaceSearchWidget extends StatelessWidget {
  final MapController mapController = Get.put(MapController());
  final SignUpScreenController signUpScreenController = Get.put(SignUpScreenController());

  PlaceSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search TextField
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
            controller: signUpScreenController.addressController,
            decoration: InputDecoration(
              hintText: 'Address',
              hintStyle: TextStyle(color: AppColours.grey, fontFamily: AppFonts.fontFamily),
              prefixIcon: const Icon(Icons.location_on, size: 18, color: AppColours.grey),
              border: InputBorder.none, // Keep this as none
              enabledBorder: InputBorder.none, // Add this
              focusedBorder: InputBorder.none, // Add this
              errorBorder: InputBorder.none, // Add this
              disabledBorder: InputBorder.none, // Add this
              focusedErrorBorder: InputBorder.none, // Add this
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              suffixIcon: Obx(() {
                if (mapController.searchQuery.isNotEmpty) {
                  return IconButton(
                    icon: const Icon(Icons.clear, color: AppColours.grey),
                    onPressed: () {
                      Get.find<SignUpScreenController>().addressController.clear();
                      mapController.clearSearch();
                      signUpScreenController.addressController.clear();
                    },
                  );
                }
                return const SizedBox();
              }),
              filled: true,
              fillColor: Colors.transparent, // Change this to transparent
            ),
            onChanged: (value) {
              mapController.searchQuery.value = value;
              if (value.length > 2) {
                mapController.searchPlaces(value);
              } else {
                mapController.predictions.clear();
              }
            },
          ),
        ),
        // Loading indicator
        Obx(() => mapController.isLoading.value
            ? const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        )
            : const SizedBox.shrink()),

        // Predictions list
        Obx(() => mapController.predictions.isNotEmpty
            ? Container(
          height: AppStyle.heightPercent(context, 22),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                color: Colors.grey.withOpacity(0.3),
              ),
            ],
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: mapController.predictions.length,
            itemBuilder: (context, index) {
              final prediction = mapController.predictions[index];
              return ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                leading: const Icon(Icons.location_on, color: Colors.blue, size: 18),
                title: Text(
                  prediction.mainText,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: Text(prediction.secondaryText),
                onTap: () {
                  // Call getPlaceDetails first, then handle the result
                  mapController.getPlaceDetails(prediction.placeId).then((_) {
                    // This code runs after getPlaceDetails completes
                    if (mapController.selectedPlace.value != null) {
                       signUpScreenController.addressController.text = mapController.selectedPlace.value!.address;
                    }
                  });
                  // Hide keyboard immediately
                  FocusScope.of(context).unfocus();
                },
              );
            },
          ),
        )
            : const SizedBox.shrink()),
      ],
    );
  }
}