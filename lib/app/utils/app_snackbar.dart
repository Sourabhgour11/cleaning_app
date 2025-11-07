import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cleaning_app/app/utils/app_colours.dart';
import 'package:cleaning_app/app/utils/app_fonts.dart';

enum SnackbarType { success, error, warning, info }

class AppSnackbar {
  static void show({
    required String message,
    String? title,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.BOTTOM,
    bool showProgressIndicator = false,
    VoidCallback? onTap,
    String? actionLabel,
    VoidCallback? onActionTap,
  }) {
    final snackbarData = _getSnackbarData(type);

    Get.snackbar(
      title ?? snackbarData['title'],
      message,
      backgroundColor: snackbarData['backgroundColor'],
      colorText: snackbarData['textColor'],
      icon: snackbarData['icon'],
      shouldIconPulse: true,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      duration: duration,
      snackPosition: position,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      borderWidth: 1,
      borderColor: snackbarData['borderColor'],
      boxShadows: [
        BoxShadow(
          color: snackbarData['backgroundColor'].withOpacity(0.3),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      titleText: Text(
        title ?? snackbarData['title'],
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: snackbarData['textColor'],
          fontFamily: AppFonts.fontFamily,
          letterSpacing: 0.3,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: snackbarData['textColor'].withOpacity(0.9),
          fontFamily: AppFonts.fontFamily,
          height: 1.3,
        ),
      ),
      showProgressIndicator: showProgressIndicator,
      progressIndicatorBackgroundColor: snackbarData['textColor'].withOpacity(
        0.3,
      ),
      progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(
        snackbarData['textColor'],
      ),
      onTap: onTap != null ? (snack) => onTap() : null,
      mainButton: actionLabel != null && onActionTap != null
          ? TextButton(
              onPressed: onActionTap,
              child: Text(
                actionLabel,
                style: TextStyle(
                  color: snackbarData['textColor'],
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.fontFamily,
                ),
              ),
            )
          : null,
      animationDuration: const Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
    );
  }

  static Map<String, dynamic> _getSnackbarData(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return {
          'title': 'Success',
          'backgroundColor': const Color(0xFF4CAF50),
          'textColor': Colors.white,
          'borderColor': const Color(0xFF45A049),
          'icon': Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
        };
      case SnackbarType.error:
        return {
          'title': 'Error',
          'backgroundColor': const Color(0xFFF44336),
          'textColor': Colors.white,
          'borderColor': const Color(0xFFE53935),
          'icon': Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
        };
      case SnackbarType.warning:
        return {
          'title': 'Warning',
          'backgroundColor': const Color(0xFFFF9800),
          'textColor': Colors.white,
          'borderColor': const Color(0xFFF57C00),
          'icon': Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.warning_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        };
      case SnackbarType.info:
        return {
          'title': 'Info',
          'backgroundColor': AppColours.appColor,
          'textColor': Colors.white,
          'borderColor': AppColours.appColor2,
          'icon': Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
        };
    }
  }

  // Convenience methods for different snackbar types
  static void success({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
    String? actionLabel,
    VoidCallback? onActionTap,
  }) {
    show(
      message: message,
      title: title,
      type: SnackbarType.success,
      duration: duration,
      onTap: onTap,
      actionLabel: actionLabel,
      onActionTap: onActionTap,
    );
  }

  static void error({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onTap,
    String? actionLabel,
    VoidCallback? onActionTap,
  }) {
    show(
      message: message,
      title: title,
      type: SnackbarType.error,
      duration: duration,
      onTap: onTap,
      actionLabel: actionLabel,
      onActionTap: onActionTap,
    );
  }

  static void warning({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
    String? actionLabel,
    VoidCallback? onActionTap,
  }) {
    show(
      message: message,
      title: title,
      type: SnackbarType.warning,
      duration: duration,
      onTap: onTap,
      actionLabel: actionLabel,
      onActionTap: onActionTap,
    );
  }

  static void info({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
    String? actionLabel,
    VoidCallback? onActionTap,
  }) {
    show(
      message: message,
      title: title,
      type: SnackbarType.info,
      duration: duration,
      actionLabel: actionLabel,
      onActionTap: onActionTap,
    );
  }

  // Custom snackbar with gradient background
  static void showGradient({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    Get.snackbar(
      title ?? 'Notification',
      message,
      backgroundColor: Colors.transparent,
      colorText: Colors.white,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.notifications_outlined,
          color: Colors.white,
          size: 24,
        ),
      ),
      shouldIconPulse: true,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      duration: duration,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      boxShadows: [
        BoxShadow(
          color: AppColours.appColor.withOpacity(0.3),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      titleText: Text(
        title ?? 'Notification',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: AppFonts.fontFamily,
          letterSpacing: 0.3,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white.withOpacity(0.9),
          fontFamily: AppFonts.fontFamily,
          height: 1.3,
        ),
      ),
      onTap: onTap != null ? (snack) => onTap() : null,
      animationDuration: const Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
    );
  }

  // Loading snackbar
  static void showLoading({required String message, String? title}) {
    show(
      message: message,
      title: title,
      type: SnackbarType.info,
      duration: const Duration(minutes: 1), // Long duration for loading
      showProgressIndicator: true,
    );
  }

  // Dismiss all snackbars
  static void dismissAll() {
    Get.closeAllSnackbars();
  }
}
