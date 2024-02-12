import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class AddToWishController extends GetxController {
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;



  Future<bool> addToWish(int productId) async {
    final response =
        await NetworkCaller().getRequest(Urls.createWishList(productId));
    if (response.isSuccess) {
      _isSuccess = true;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return _isSuccess;
  }
}
