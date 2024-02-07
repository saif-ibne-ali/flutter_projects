import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  CartListModel _cartListModel = CartListModel();
  CartListModel get cartList => _cartListModel;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    ResponseData response = await NetworkCaller().getRequest(Urls.addToCart);
    if (response.isSuccess) {
      _cartListModel = CartListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
