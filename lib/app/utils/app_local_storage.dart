import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save user data (userId, token, and all user details)
  static Future<bool> saveUserData({
    required String userId,
    required String token,
    Map<String, dynamic>? userDetails,
  }) async {
    try {
      await _prefs?.setString('user_id', userId);
      await _prefs?.setString('token', token);

      if (userDetails != null) {
        await _prefs?.setString('user_details', jsonEncode(userDetails));
      }

      await _prefs?.setBool('is_logged_in', true);

      return true;
    } catch (e) {
      print('Error saving user data: $e');
      return false;
    }
  }


  // Get user ID
  static String? getUserId() {
    return _prefs?.getString('user_id');
  }

  // Get token
  static String? getToken() {
    return _prefs?.getString('token');
  }

  // Get user details as Map
  static Map<String, dynamic>? getUserDetails() {
    try {
      String? userDetailsJson = _prefs?.getString('user_details');
      return jsonDecode(userDetailsJson!);
    } catch (e) {
      print('Error getting user details: $e');
      return null;
    }
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return _prefs?.getBool('is_logged_in') ?? false;
  }

  // Clear all user data (logout)
  static Future<bool> clearUserData() async {
    try {
      await _prefs?.remove('user_id');
      await _prefs?.remove('token');
      await _prefs?.remove('user_details');
      await _prefs?.setBool('is_logged_in', false);
      return true;
    } catch (e) {
      print('Error clearing user data: $e');
      return false;
    }
  }

  // Get all stored user data as a single map
  static Map<String, dynamic>? getAllUserData() {
    try {
      String? userId = getUserId();
      String? token = getToken();
      Map<String, dynamic>? userDetails = getUserDetails();

      if (userId != null && token != null) {
        return {
          'user_id': userId,
          'token': token,
          'user_details': userDetails,
          'is_logged_in': isLoggedIn(),
        };
      }
      return null;
    } catch (e) {
      print('Error getting all user data: $e');
      return null;
    }
  }

  // Save individual preference
  static Future<bool> saveString(String key, String value) async {
    try {
      return await _prefs?.setString(key, value) ?? false;
    } catch (e) {
      print('Error saving string: $e');
      return false;
    }
  }

  // Get individual preference
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Save boolean
  static Future<bool> saveBool(String key, bool value) async {
    try {
      return await _prefs?.setBool(key, value) ?? false;
    } catch (e) {
      print('Error saving bool: $e');
      return false;
    }
  }

  // Get boolean
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Remove specific key
  static Future<bool> remove(String key) async {
    try {
      return await _prefs?.remove(key) ?? false;
    } catch (e) {
      print('Error removing key: $e');
      return false;
    }
  }

  // Clear all preferences
  static Future<bool> clearAll() async {
    try {
      return await _prefs?.clear() ?? false;
    } catch (e) {
      print('Error clearing all: $e');
      return false;
    }
  }
}
