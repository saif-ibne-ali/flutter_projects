import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/controllers/new_task_controller.dart';
import 'package:task_manger/controllers/task_count_controller.dart';
import 'package:task_manger/ui/screens/add_new_task_screen.dart';
import 'package:task_manger/ui/widgets/profile_summary_card.dart';
import 'package:task_manger/ui/widgets/task_count_summary_card.dart';
import 'package:task_manger/ui/widgets/task_item_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<TaskCountController>().getTaskCountSummaryList();
    Get.find<NewTaskController>().getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddNewTaskScreen());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            const TaskCountSummaryCard(),
            Expanded(
              child:
                  GetBuilder<NewTaskController>(builder: (newTaskController) {
                return Visibility(
                  visible: newTaskController.getNewTaskInprogress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () => newTaskController.getNewTaskList(),
                    child: ListView.builder(
                      itemCount:
                          newTaskController.taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task:
                              newTaskController.taskListModel.taskList![index],
                        );
                      },
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
