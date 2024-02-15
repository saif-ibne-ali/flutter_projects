import 'package:crafty_bay/data/models/wish_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  WishListModel _wishListModel = WishListModel();
  WishListModel get wishList => _wishListModel;

  String _removeStatus = '';
  String get removeStatus => _removeStatus;

  String _addStatus = '';
  String get addStatus => _addStatus;

  Future<bool> getWishProductList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.productWishList);
    _inProgress = false;
    if (response.isSuccess) {
      _wishListModel = WishListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }

  Future<bool> deleteWishItem(int productID) async {
    bool isSuccess = false;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.removeWishList(productID));
    if (response.isSuccess && response.responseData['data'] == 1) {
      _removeStatus = 'The item has been removed';
      await getWishProductList();
      isSuccess = true;
    } else if (response.isSuccess && response.responseData['data'] == 0) {
      _removeStatus = 'Item does not exist';
      return isSuccess;
    } else {
      _removeStatus = response.errorMessage;
    }
    update();
    return isSuccess;
  }

  Future<bool> addToWish(int productId) async {
    bool isSuccess = false;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.createWishList(productId));
    if (response.isSuccess) {
      _addStatus = 'The item has been add to your wishlist';
      await getWishProductList();
      isSuccess = true;
    } else {
      _addStatus = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
