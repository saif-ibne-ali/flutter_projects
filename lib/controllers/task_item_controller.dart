import 'package:get/get.dart';
import 'package:task_manger/data/model/task.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/utility/urls.dart';

class TaskItemController extends GetxController {
  final RxBool showProgress = false.obs;

  Future<bool> updateTaskStatus(Task task, String status) async {
    //showProgress.value = true;
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(task.sId ?? '', status));

    if (response.isSuccess) {
      return true;
    }
    //showProgress.value = false;
    return false;
  }

  Future<bool> deleteTask(Task task) async {
    //showProgress.value = true;
    final response =
        await NetworkCaller().getRequest(Urls.deleteTask(task.sId ?? ''));

    if (response.isSuccess) {
      return true;
    }
    //showProgress.value = false;
    return false;
  }
}
