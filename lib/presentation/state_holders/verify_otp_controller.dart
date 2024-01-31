import 'dart:developer';

import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/read_profile_data_controller.dart';
import 'package:get/get.dart';

class VerifyOTPController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _doNavigateCompleteProfile = true;
  bool get doNavigateCompleteProfile => _doNavigateCompleteProfile;

  Future<bool> verifyOTP(String email, String otp) async {
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.verifyOtp(email, otp));
    _inProgress = false;
    if (response.isSuccess && response.responseData['msg'] != 'fail') {
      await Future.delayed(const Duration(seconds: 3));
      final token = response.responseData['data'];
      log(token.toString());
      final result =
          await Get.find<ReadProfileDataController>().readProfileData(token);
      if (result) {
        _doNavigateCompleteProfile =
            Get.find<ReadProfileDataController>().isProfileCompleted == false;
        if (_doNavigateCompleteProfile == false) {
          await Get.find<AuthController>().saveUserDetails(
              token, Get.find<ReadProfileDataController>().profile);
        }
      } else {
        _errorMessage = Get.find<ReadProfileDataController>().errorMessage;
        update();
        return false;
      }
      //TODO: save to local cache
      //Condition: If user profile completed, then save existing info
      //Otherwise complete profile and then save info
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return true;
    }
  }
}