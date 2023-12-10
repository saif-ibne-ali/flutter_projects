import 'package:get/get.dart';
import 'package:task_manger/data/model/task_count_summary_list_model.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';

class TaskCountController extends GetxController{
  bool _getTaskCountSummaryInProgress = false;
   TaskCountSummaryListModel _taskCountSummaryListModel =
      TaskCountSummaryListModel();
  
  bool get getTaskCountSummaryInProgress => _getTaskCountSummaryInProgress;
    TaskCountSummaryListModel get taskCountSummaryListModel =>
      _taskCountSummaryListModel;


    Future<bool> getTaskCountSummaryList() async {
    _getTaskCountSummaryInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);

    if (response.isSuccess) {
      _taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
      return true;
    }
    _getTaskCountSummaryInProgress = false;
    update();
    return false;
  }
}