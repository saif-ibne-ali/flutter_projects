import 'package:crafty_bay/data/models/cart_model.dart';
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

  final RxDouble _totalPrice = 0.0.obs;
  RxDouble get totalPrice => _totalPrice;

  String _deleteStatus = '';
  String get deleteStatus => _deleteStatus;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    ResponseData response = await NetworkCaller().getRequest(Urls.cartList);
    if (response.isSuccess) {
      _cartListModel = CartListModel.fromJson(response.responseData);
      _totalPrice.value = _calculateTotalPrice;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> deleteCartItem(int productID) async {
    bool isSuccess = false;
    update();
    ResponseData response =
        await NetworkCaller().getRequest(Urls.deleteCartList(productID));
    if (response.isSuccess && response.responseData['data'] == 1) {
      _deleteStatus = 'The item has been deleted';
      await getCartList();
      isSuccess = true;
    } else if (response.isSuccess && response.responseData['data'] == 0) {
      _deleteStatus = 'Item does not exist';
      return isSuccess;
    } else{
      _deleteStatus = response.errorMessage;
    }
    update();
    return isSuccess;
  }

  void updateQuantity(int id, int quantity) {
    _cartListModel.cartItemList?.firstWhere((element) => element.id == id).qty =
        quantity;
    _totalPrice.value = _calculateTotalPrice;
  }

  double get _calculateTotalPrice {
    double total = 0;
    for (CartModel item in _cartListModel.cartItemList ?? []) {
      total += (double.tryParse(item.product?.price ?? '0') ?? 0) * item.qty!;
    }
    return total;
  }
}
