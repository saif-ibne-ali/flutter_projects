import 'package:get/get.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';

class ResetPasswordController extends GetxController {
  bool _isResetPasswordInProgress = false;
  bool get isResetPasswordInProgress => _isResetPasswordInProgress;

  String _showMessage = '';
  String get showMessage => _showMessage;

  Future<bool> getPasswordReset(
      String email, String otp, String password) async {
    _isResetPasswordInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().postRequest(Urls.recoverResetPass, body: {
      "email": email,
      "OTP": otp,
      "password": password,
    });
    _isResetPasswordInProgress = false;
    update();
    if (response.isSuccess && response.jsonResponse['status'] != 'fail') {
      _showMessage = 'Password recover is successful ';
      return true;
    } else {
      _showMessage = 'Something Wrong! Try again.';
      return false;
    }
  }
}
