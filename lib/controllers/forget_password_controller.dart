import 'package:get/get.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';

class ForgetPasswordController extends GetxController {
  bool _verifyEmailInProgress = false;
  bool get verifyEmailInProgress => _verifyEmailInProgress;

  String _showMessage = '';
  String get showMessage => _showMessage;

  Future<bool> getVerifyEmail(String email) async {
    _verifyEmailInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller().getRequest(
      Urls.recoverVerifyEmail(email),
    );
    _verifyEmailInProgress = false;
    update();
    if (response.isSuccess && response.jsonResponse['status'] != 'fail') {
      _showMessage = 'An OTP has been sent to your email address';
      return true;
    } else {
      if (response.jsonResponse['status'] == 'fail') {
        _showMessage = '${response.jsonResponse['data']}. Check Your Email.';
      } else {
        _showMessage = 'Check Your Internet Connection';
      }
      return false;
    }
  }
}
