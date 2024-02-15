import 'package:crafty_bay/data/models/review_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReviewListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  ReviewListModel _reviewListModel = ReviewListModel();
  ReviewListModel get reviewListModel => _reviewListModel;

  Future<bool> getReviewList(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.listReviewByProduct(productId));
    if (response.isSuccess) {
      _reviewListModel = ReviewListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
