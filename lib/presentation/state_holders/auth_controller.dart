import 'dart:convert';

import 'package:crafty_bay/data/models/profile_model.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/validate_email_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static String? token;
  static ProfileModel? profile;

  Future<void> saveUserDetails(String t, ProfileModel p) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', t);
    await sharedPreferences.setString('profile', jsonEncode(p.toJson()));
    token = t;
    profile = p;
  }

  Future<void> initialize() async {
    token = await _getToken();
    profile = await _getProfile();
  }

  Future<bool> isLoggedIn() async {
    await initialize();
    return token != null;
  }

  bool get isTokenNotNull => token != null;

  Future<String?> _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<ProfileModel?> _getProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? strProfile = sharedPreferences.getString('profile');
    if (strProfile == null) {
      return null;
    } else {
      return ProfileModel.fromJson(jsonDecode(strProfile));
    }
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
  }

  static Future<void> goToLogin() async {
    Get.to(() => const ValidateEmailScreen());
  }
}