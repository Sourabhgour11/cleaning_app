import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'app_fonts.dart';


class AppCameraPopup {
  static Future<File?> showImageSourceDialog(BuildContext context) async {
    return await showModalBottomSheet<File?>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Container(
          margin:  EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: AppColours.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 0,
                offset: const Offset(0, -10),
              ),
              BoxShadow(
                color: AppColours.appColor.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: Container(
              color: AppColours.white,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                // Handle bar
                Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(top: 15, bottom: 25),
                  decoration: BoxDecoration(
                    color: AppColours.appColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                
                // Title with gradient
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        '📸 Select Image Source',
                        style: TextStyle(
                          fontFamily: AppFonts.fontFamily,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColours.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Choose how you want to add your product image',
                        style: TextStyle(
                          fontFamily: AppFonts.fontFamily,
                          fontSize: 14,
                          color: AppColours.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Options
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Camera option
                      _buildOptionButton(
                        context: context,
                        icon: Icons.camera_alt_rounded,
                        title: 'Take Photo',
                        subtitle: 'Capture a new photo with your camera',
                        gradient: const LinearGradient(
                          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () async {
                          final File? image = await _pickImage(context, ImageSource.camera);
                          if (context.mounted) {
                            if (image != null) {
                              Navigator.pop(context, image);
                            }
                            // If image is null (user cancelled), don't pop the modal
                            // Let the user try again or use cancel button
                          }
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Gallery option
                      _buildOptionButton(
                        context: context,
                        icon: Icons.photo_library_rounded,
                        title: 'Choose from Gallery',
                        subtitle: 'Select an existing photo from your gallery',
                        gradient: const LinearGradient(
                          colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () async {
                          final File? image = await _pickImage(context, ImageSource.gallery);
                          if (context.mounted) {
                            if (image != null) {
                              Navigator.pop(context, image);
                            }
                            // If image is null (user cancelled), don't pop the modal
                            // Let the user try again or use cancel button
                          }
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Cancel button
                      _buildCancelButton(context),
                      
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildOptionButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColours.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColours.appColor.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                  color: gradient.colors.first.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: gradient.colors.first.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 0,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: AppColours.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: AppFonts.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColours.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: AppFonts.fontFamily,
                          fontSize: 14,
                          color: AppColours.black,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: gradient.colors.first.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: gradient.colors.first,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildCancelButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 1,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: AppColours.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.close_rounded,
                  color: Colors.grey[600],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: AppFonts.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<File?> _pickImage(BuildContext context, ImageSource source) async {
    try {
      print('Picking image from ${source == ImageSource.camera ? 'camera' : 'gallery'}');
      final ImagePicker picker = ImagePicker();
      
      // Check if the source is available
      if (source == ImageSource.camera) {
        print('Checking camera availability...');
      } else {
        print('Checking gallery availability...');
      }
      
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          print('Image picker timed out');
          return null;
        },
      );
      
      print('Image picker returned: ${image?.path ?? 'null'}');
      
      if (image != null) {
        print('Image selected: ${image.path}');
        final file = File(image.path);
        print('File exists: ${file.existsSync()}');
        if (file.existsSync()) {
          print('File size: ${file.lengthSync()} bytes');
          return file;
        } else {
          print('File does not exist at path: ${image.path}');
          return null;
        }
      } else {
        print('No image selected - user cancelled or error occurred');
        return null;
      }
    } catch (e) {
      if (context.mounted) {
        String errorMessage = 'Error picking image';
        
        if (e.toString().contains('Permission denied')) {
          errorMessage = 'Permission denied. Please allow camera and storage access in settings.';
        } else if (e.toString().contains('No image selected')) {
          errorMessage = 'No image selected';
        } else {
          errorMessage = 'Error picking image: ${e.toString()}';
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: TextStyle(
                fontFamily: AppFonts.fontFamily,
                color: AppColours.white,
              ),
            ),
            backgroundColor: AppColours.grey,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'OK',
              textColor: AppColours.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
      return null;
    }
  }
}

// Extension to show the popup easily
extension AppCameraPopupExtension on BuildContext {
  Future<File?> showImageSourceDialog() {
    return AppCameraPopup.showImageSourceDialog(this);
  }
}
