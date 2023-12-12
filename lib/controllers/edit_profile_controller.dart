import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manger/controllers/auth_controller.dart';
import 'package:task_manger/data/model/user_model.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';

class EditProfileController extends GetxController {
  bool _updateProfileInProgress = false;
  String _message = '';
  String? photoInBase64;

  bool get updateProfileInProgress => _updateProfileInProgress;
  String get message => _message;

  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobile, String password, XFile? photo) async {
    _updateProfileInProgress = true;
    update();

    Map<String, dynamic> inputData = {
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password.isNotEmpty) {
      inputData['password'] = password;
    }

    if (photo != null) {
      List<int> imageBytes = await photo.readAsBytes();
      photoInBase64 = base64Encode(imageBytes);
      inputData['photo'] = photoInBase64;
    }

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.updateProfile,
      body: inputData,
    );
    _updateProfileInProgress = false;
    update();
    if (response.isSuccess && response.jsonResponse['status'] != 'fail') {
      Get.find<AuthController>().updateUserInformation(UserModel(
          email: email,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
          photo: photoInBase64 ?? Get.find<AuthController>().user?.photo));
      _message = 'Update profile success!';
      return true;
    } else {
      _message = 'Update profile failed. Try again.';
      return false;
    }
  }
}
