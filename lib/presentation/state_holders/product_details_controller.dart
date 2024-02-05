import 'package:crafty_bay/data/models/product_details_data.dart';
import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _inprogress = false;
  bool get inprogress => _inprogress;

  ProductDetailsModel _productDetailsModel = ProductDetailsModel();
  ProductDetailsData get productDetailsModel => _productDetailsModel.productDetailsDataList!.first;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    _inprogress == true;
    update();
    final ResponseData response =
        await NetworkCaller().getRequest(Urls.productDetails(productId));
    if (response.isSuccess) {
      _productDetailsModel =
          ProductDetailsModel.fromJson(response.responseData);
    } else{
      _errorMessage = response.errorMessage;
    }
    _inprogress = false;
    update();
    return isSuccess;
  }
}
