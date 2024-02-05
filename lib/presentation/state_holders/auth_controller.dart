import 'dart:convert';

import 'package:crafty_bay/data/models/profile.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {

  String? token;
  Profile? profile;

  Future<void> saveUserDetails(String userToken, Profile userProfile) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', userToken);
    await sharedPreferences.setString('profile', jsonEncode(userProfile.toJson()));
    token = userToken;
    profile = userProfile;
  }

  Future<void> initialize() async {
    token = await _getToken();
    profile = await _getProfile();
  }

  Future<bool> isloggedIn() async {
    await initialize();
    return token != null;
  }

  bool get isTokenNotNull => token == null;

  Future<String?> _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<Profile?> _getProfile() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? strProfile =  sharedPreferences.getString('profile');
    if(strProfile==null){
      return null;
    } else {
      return Profile.fromJson(jsonDecode(strProfile));
    }
  }

  Future<void> clearAuthData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
