import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/controllers/task_count_controller.dart';
import 'package:task_manger/data/model/task_count.dart';

class TaskCountSummaryCard extends StatelessWidget {
  const TaskCountSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskCountController>(builder: (taskCountController) {
      return Visibility(
        visible: taskCountController.getTaskCountSummaryInProgress == false &&
            (taskCountController
                    .taskCountSummaryListModel.taskCountList?.isNotEmpty ??
                false),
        replacement: const LinearProgressIndicator(),
        child: SizedBox(
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: taskCountController
                      .taskCountSummaryListModel.taskCountList?.length ??
                  0,
              itemBuilder: (context, index) {
                TaskCount taskCount = taskCountController
                    .taskCountSummaryListModel.taskCountList![index];
                return FittedBox(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: Column(children: [
                        Text(
                          taskCount.sum.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(taskCount.sId ?? ''),
                      ]),
                    ),
                  ),
                );
              }),
        ),
      );
    });
  }
}
