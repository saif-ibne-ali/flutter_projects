import 'package:flutter/material.dart';
import 'package:task_manger/data/model/task_list_model.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';
import 'package:task_manger/ui/widgets/profile_summary_card.dart';
import 'package:task_manger/ui/widgets/task_item_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool getCancelledTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getCancelledTaskList() async {
    getCancelledTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCancelledTask);

    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCancelledTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        const ProfileSummaryCard(),
        Expanded(
            child: Visibility(
          visible: getCancelledTaskInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: getCancelledTaskList,
            child: ListView.builder(
              itemCount: taskListModel.taskList?.length ?? 0,
              itemBuilder: (context, index) {
                return TaskItemCard(
                  task: taskListModel.taskList![index],
                  onStatusChange: () {
                    getCancelledTaskList();
                  },
                  showProgress: (inProgress) {
                    getCancelledTaskInProgress = inProgress;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                );
              },
            ),
          ),
        ))
      ],
    )));
  }
}
