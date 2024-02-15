import 'package:crafty_bay/data/models/review_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CreateReviewController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> createReview(ReviewModel params) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response =
    await NetworkCaller().postRequest(Urls.createProductReview,body: params.toJson());
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
