import 'dart:developer';

import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/read_profile_controller.dart';
import 'package:get/get.dart';

class VerifyOTPController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _doNavigateCompleteProfile = true;
  bool get doNavigateCompleteProfile => _doNavigateCompleteProfile;

  String _token = '';
  String get token => _token;

  Future<bool> verifyOTP(String email, String otp) async {
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.verifyOtp(email, otp), skipAuthCheck: true);
    _inProgress = false;
    if (response.isSuccess) {
      _token = response.responseData['data'];
      await Future.delayed(const Duration(seconds: 3));
      log(token.toString());
      final result =
          await Get.find<ReadProfileController>().readProfileData(token);
      if (result) {
        _doNavigateCompleteProfile =
            Get.find<ReadProfileController>().isProfileCompleted == false;
        if (_doNavigateCompleteProfile == false) {
          await Get.find<AuthController>().saveUserDetails(
              token, Get.find<ReadProfileController>().profile);
        }
      } else {
        _errorMessage = Get.find<ReadProfileController>().errorMessage;
        update();
        return false;
      }
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
