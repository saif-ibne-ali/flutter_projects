import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/controllers/add_new_task_controller.dart';
import 'package:task_manger/controllers/new_task_controller.dart';
import 'package:task_manger/controllers/task_count_controller.dart';
import 'package:task_manger/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manger/ui/widgets/body_background.dart';
import 'package:task_manger/ui/widgets/profile_summary_card.dart';
import 'package:task_manger/ui/widgets/show_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AddNewTaskController _addNewTaskController = AddNewTaskController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          } else {
            Get.offAll(() => const MainBottomNavScreen());
          }
        },
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
                child: BodyBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          Text(
                            'Add New Task',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _subjectTEController,
                            decoration:
                                const InputDecoration(hintText: 'Subject'),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your subject';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _descriptionTEController,
                            maxLines: 8,
                            decoration:
                                const InputDecoration(hintText: 'Description'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: GetBuilder<AddNewTaskController>(
                                builder: (addNewTaskController) {
                              return Visibility(
                                visible:
                                    !addNewTaskController.createTaskInProgress,
                                replacement: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                child: ElevatedButton(
                                  onPressed: _createTask,
                                  child: const Icon(
                                      Icons.arrow_circle_right_outlined),
                                ),
                              );
                            }),
                          )
                        ]),
                  ),
                ),
              ),
            ))
          ],
        ),
      )),
    );
  }

  Future<void> _createTask() async {
    if (_formkey.currentState!.validate()) {
      final response = await _addNewTaskController.createTask(
          _subjectTEController.text.trim(),
          _descriptionTEController.text.trim());
      if (response) {
        _subjectTEController.clear();
        _descriptionTEController.clear();
        Get.find<NewTaskController>().getNewTaskList();
        Get.find<TaskCountController>().getTaskCountSummaryList();
        if (mounted) {
          showSnackMessage(context, _addNewTaskController.message);
        }
      } else {
        if (mounted) {
          showSnackMessage(context, _addNewTaskController.message);
        }
      }
    }
    Future.delayed(const Duration(seconds: 2)).then((value) => Get.back());
  }

  @override
  void dispose() {
    _descriptionTEController.dispose();
    _subjectTEController.dispose();
    super.dispose();
  }
}
