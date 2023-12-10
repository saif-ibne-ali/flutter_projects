import 'package:get/get.dart';
import 'package:task_manger/data/model/task_list_model.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';

class CancelledTaskController extends GetxController {
  bool _getCancelledTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCancelledTaskInProgress => _getCancelledTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<void> getCancelledTaskList() async {
    _getCancelledTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCancelledTask);

    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getCancelledTaskInProgress = false;
    update();
  }
}
