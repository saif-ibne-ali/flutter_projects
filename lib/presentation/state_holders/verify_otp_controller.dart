
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class VerifyOTPController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> verifyOTP(String email, String otp) async{
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.verifyOtp(email, otp));
    _inProgress = false;
    if(response.isSuccess && response.responseData['msg']!='fail'){
      final token = response.responseData['data'];
      //TODO: save to local cache
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return true;
    }
  }
}