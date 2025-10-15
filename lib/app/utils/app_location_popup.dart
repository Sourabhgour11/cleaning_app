import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLocationPopup {
  Future<String> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location service is enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await _showPopup(
          "Location Service Disabled",
          "Please enable location service from settings.",
        );
        return "";
      }

      // Check permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          await _showPopup(
            "Permission Denied",
            "Please allow location permission to get your current city.",
          );
          return "";
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await _showPopup(
          "Permission Denied Forever",
          "You have permanently denied location permission. Please enable it from settings.",
        );
        return "";
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Convert coordinates to place name
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return placemarks.first.locality ?? "Unknown Location";
    } catch (e) {
      print("Error getting location: $e");
      await _showPopup(
        "Location Error",
        "Unable to get your current location. Please try again.",
      );
      return "";
    }
  }

  // Function to show popup
  Future<void> _showPopup(String title, String message) async {
    return showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
