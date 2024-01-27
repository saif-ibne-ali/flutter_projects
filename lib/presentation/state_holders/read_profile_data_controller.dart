import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReadProfileDataController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> readProfileData(String token) async {
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.readProfile, token: token);
    _inProgress = false;
    if (response.isSuccess && response.responseData['msg'] != 'fail') {
      final profileData = response.responseData['data'];
      if(profileData== null){
        update();
        return false;
      } else{
        update();
        return true;
      }
    } else {
      _errorMessage = response.errorMessage;
      update();
      return true;
    }
  }
}
