import 'package:crafty_bay/data/models/profile.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CompleteProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Profile _profile = Profile();
  Profile get profile => _profile;

  Future<bool> createProfile(String token, String firstName, String lastName,
      String mobile, String city, String shippingAddress) async {
    //Flutter Ecommerce Project-04(Live class-01)
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().postRequest(Urls.createProfile, token: token);
    _inProgress = false;
    if (response.isSuccess && response.responseData['msg'] != 'fail') {
      _profile = Profile.fromJson(response.responseData['data']);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
