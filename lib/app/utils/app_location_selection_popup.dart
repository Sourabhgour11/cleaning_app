import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_location_popup.dart';
import '../modules/user app/home_screen/home_screen_controller.dart';

class AppLocationSelectionPopup {
  static Future<String?> showLocationSelectionDialog() async {
    return await showDialog<String>(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Select Your Location',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Description
                const Text(
                  'Choose how you\'d like to set your location',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Current Location Button
                _buildLocationOption(
                  context: context,
                  icon: Icons.my_location,
                  title: 'Use Current Location',
                  subtitle: 'Get your location automatically',
                  color: Colors.green,
                  onTap: () async {
                    Navigator.of(context).pop(); // Close dialog first
                    await _getCurrentLocation(context);
                  },
                ),

                const SizedBox(height: 16),

                // Manual Entry Button
                _buildLocationOption(
                  context: context,
                  icon: Icons.edit_location,
                  title: 'Enter Manually',
                  subtitle: 'Type your city or address',
                  color: Colors.blue,
                  onTap: () async {
                    Navigator.of(context).pop(); // Close dialog first
                    await _showManualLocationDialog(context);
                  },
                ),

                const SizedBox(height: 20),

                // Cancel Button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildLocationOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.05),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> _getCurrentLocation(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final locationPopup = AppLocationPopup();
      final location = await locationPopup.getCurrentLocation();

      // Close loading dialog
      Navigator.of(context).pop();

      if (location.isNotEmpty && location != "Unknown Location") {
        // Show success and return location
        Get.snackbar(
          'Location Found',
          'Your location: $location',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // Update the home screen location
        try {
          Get.find<HomeScreenController>().updateLocation(location);
        } catch (e) {
          // Controller not found, location will be shown in snackbar only
        }
      } else {
        // Show error and fallback to manual entry
        Get.snackbar(
          'Location Error',
          'Could not get current location. Please try manual entry.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );

        // Show manual entry dialog as fallback
        await _showManualLocationDialog(context);
      }
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();

      Get.snackbar(
        'Error',
        'Failed to get location: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  static Future<void> _showManualLocationDialog(BuildContext context) async {
    final TextEditingController locationController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(Icons.edit_location, color: Colors.blue),
              const SizedBox(width: 10),
              const Text('Enter Location'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please enter your city or address',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'e.g., New York, NY',
                  prefixIcon: const Icon(Icons.location_city),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
                autofocus: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final location = locationController.text.trim();
                if (location.isNotEmpty) {
                  Navigator.of(context).pop();
                  Get.snackbar(
                    'Location Set',
                    'Your location: $location',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );

                  // Update the home screen location
                  try {
                    Get.find<HomeScreenController>().updateLocation(location);
                  } catch (e) {
                    // Controller not found, location will be shown in snackbar only
                  }
                } else {
                  Get.snackbar(
                    'Error',
                    'Please enter a valid location',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Set Location'),
            ),
          ],
        );
      },
    );
  }
}
