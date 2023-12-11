import 'package:get/get.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;

  String _message = '';
  String get message => _message;

  Future<bool> signUp(String firstName, String lastName, String email,
      String password, String mobile) async {
    _signUpInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, body: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "mobile": mobile,
    });
    _signUpInProgress = false;
    update();
    if (response.isSuccess && response.jsonResponse['status'] != 'fail') {
      _message = 'Account has been created! Please login';
      return true;
    } else {
      _message = 'Account creation failed! Please Try again.';
      return false;
    }
  }
}
