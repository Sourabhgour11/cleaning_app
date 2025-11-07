// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_places_autocomplete_widgets_x/widgets/address_autocomplete_textformfield.dart';
// import 'location_controller.dart';
//
// class AddressAutocompleteField extends StatelessWidget {
//   final LocationController controller = Get.find<LocationController>();
//   final String hintText;
//
//   AddressAutocompleteField({Key? key, required this.hintText}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AddressAutocompleteTextFormField(
//       mapsApiKey: 'YOUR_GOOGLE_MAPS_API_KEY',
//       controller: AddressAutocompleteController(),
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         prefixIcon: const Icon(Icons.location_on),
//       ),
//       onChanged: (Place place) {
//         // Place has latLng property
//         if (place.latLng != null) {
//           controller.setLocation(place.latLng!.latitude, place.latLng!.longitude);
//         }
//         controller.addressController.text = place.description ?? '';
//       },
//     );
//   }
// }
