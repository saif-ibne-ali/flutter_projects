import 'package:crafty_bay/data/models/cart_model.dart';
import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> addToCart( CartModel params) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    ResponseData response =
        await NetworkCaller().postRequest(Urls.addToCart, body: params.toJson());
    if(response.isSuccess){
      isSuccess = true;
    } else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
