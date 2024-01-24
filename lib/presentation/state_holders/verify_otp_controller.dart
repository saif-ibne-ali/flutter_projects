
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class VerifyOTPController extends GetxController{
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<bool> verifyOTP(String email, String otp) async{
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.verifyOtp(email, otp));
    if(response.isSuccess && response.responseData['msg']!='fail'){
      final token = response.responseData['data'];

      update();
      return true;
    }
    return true;
  }
}