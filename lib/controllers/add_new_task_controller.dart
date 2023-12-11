import 'package:get/get.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';

class AddNewTaskController extends GetxController {
  bool _createTaskInProgress = false;
  String _message = '';

  bool get createTaskInProgress => _createTaskInProgress;
  String get message => _message;

  Future<bool> createTask(String title, String description) async {
    _createTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.createNewTask, body: {
      "title": title,
      "description": description,
      "status": "New",
    });
    _createTaskInProgress = false;
    update();
    if (response.isSuccess && response.jsonResponse['status'] != 'fail') {
      _message = 'New task added!';
      return true;
    } else {
      _message = 'Create new task failed! Try again.';
      return false;
    }
  }
}
