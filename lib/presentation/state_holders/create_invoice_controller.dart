import 'package:crafty_bay/data/models/payment_method_list_model.dart';
import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';

import '../../data/utility/urls.dart';

class CreateInvoiceController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  PaymentMethodListModel _paymentMethodListModel = PaymentMethodListModel();
  PaymentMethodListModel get paymentMethodList => _paymentMethodListModel;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> createInvoice() async{
    bool isSuccess = false;
    _inProgress = true;
    update();
    ResponseData response = await NetworkCaller().getRequest(Urls.createInvoice);
    if(response.isSuccess){
      _paymentMethodListModel = PaymentMethodListModel.fromJson(response.responseData);
      isSuccess = true;
    } else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}