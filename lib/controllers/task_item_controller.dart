import 'package:get/get.dart';
import 'package:task_manger/controllers/cancelled_task_controller.dart';
import 'package:task_manger/controllers/completed_task_controller.dart';
import 'package:task_manger/controllers/new_task_controller.dart';
import 'package:task_manger/controllers/progress_task_controller.dart';
import 'package:task_manger/controllers/task_count_controller.dart';
import 'package:task_manger/data/model/task.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/utility/urls.dart';

class TaskItemController extends GetxController {
  //final RxBool _showProgress = false.obs;
  //RxBool get showProgress => _showProgress;

  Future<void> updateTaskStatus(Task task, String status) async {
    //_showProgress.value = true;
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(task.sId ?? '', status));

    if (response.isSuccess) {
      Get.find<TaskCountController>().getTaskCountSummaryList();
      if (task.status == 'New') {
        Get.find<NewTaskController>().getNewTaskList();
      }
      if (task.status == 'Progress') {
        Get.find<ProgressTaskController>().getProgressTaskList();
      }
      if (task.status == 'Completed') {
        Get.find<CompletedTaskController>().getCompletedTaskList();
      }
      if (task.status == 'Cancelled') {
        Get.find<CancelledTaskController>().getCancelledTaskList();
      }
    }
    //_showProgress.value = false;
  }

  Future<void> deleteTask(Task task) async {
    //_showProgress.value = true;
    final response =
        await NetworkCaller().getRequest(Urls.deleteTask(task.sId ?? ''));

    if (response.isSuccess) {
      Get.find<TaskCountController>().getTaskCountSummaryList();
      if (task.status == 'New') {
        Get.find<NewTaskController>().getNewTaskList();
      }
      if (task.status == 'Progress') {
        Get.find<ProgressTaskController>().getProgressTaskList();
      }
      if (task.status == 'Completed') {
        Get.find<CompletedTaskController>().getCompletedTaskList();
      }
      if (task.status == 'Cancelled') {
        Get.find<CancelledTaskController>().getCancelledTaskList();
      }
    }
    //_showProgress.value = false;
  }
}
