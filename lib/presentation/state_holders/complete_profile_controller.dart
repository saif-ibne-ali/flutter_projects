import 'package:crafty_bay/data/models/profile_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class CompleteProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  ProfileModel _profile = ProfileModel();
  ProfileModel get profile => _profile;

  Future<bool> createProfile(String token, ProfileModel params) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller()
        .postRequest(Urls.createProfile, body: params.toJson(), token: token);
    if (response.isSuccess) {
      _inProgress = false;
      _profile = ProfileModel.fromJson(response.responseData['data']);
      await Get.find<AuthController>().saveUserDetails(token, _profile);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
