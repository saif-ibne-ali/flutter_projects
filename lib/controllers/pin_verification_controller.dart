import 'package:get/get.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';

class PinVerificationController extends GetxController {
  bool _isPinVerifyInProgress = false;
  bool get isPinVerifyInProgress => _isPinVerifyInProgress;

  String _showMessage = '';
  String get showMessage => _showMessage;

  Future<bool> getPinVerify(String email, String otp) async {
    _isPinVerifyInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller().getRequest(
      Urls.recoverVerifyOTP(email, otp),
    );
    _isPinVerifyInProgress = false;
    update();
    if (response.isSuccess && response.jsonResponse['status'] != 'fail') {
      _showMessage = 'Verification Successful';
      return true;
    } else {
      if (response.jsonResponse['status'] == 'fail') {
        _showMessage = '${response.jsonResponse['data']}';
      } else {
        _showMessage = 'Check Your Internet Connection & Try again';
      }
      return false;
    }
  }
}
