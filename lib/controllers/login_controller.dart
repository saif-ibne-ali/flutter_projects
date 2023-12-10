import 'package:get/get.dart';
import 'package:task_manger/controllers/auth_controller.dart';
import 'package:task_manger/data/model/user_model.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String _failedmessage = '';

  bool get loginInProgress => _loginInProgress;
  String get failureMessage => _failedmessage;

  Future<bool> login(String email, String password) async {
    _loginInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller().postRequest(Urls.login,
        body: {
          'email': email,
          'password': password,
        },
        isLogin: true);
    _loginInProgress = false;
    update();
    if (response.isSuccess) {
      await Get.find<AuthController>().saveUserInformation(
          response.jsonResponse?['token'],
          UserModel.fromJson(response.jsonResponse?['data']));
      return true;
    } else {
      if (response.statusCode == 401) {
        _failedmessage = 'Please Check email/password';
      } else {
        _failedmessage = 'login failed! Try again';
      }
    }
    return false;
  }
}
