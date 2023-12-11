import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/controllers/add_new_task_controller.dart';
import 'package:task_manger/controllers/auth_controller.dart';
import 'package:task_manger/controllers/bottom_navigation_bar_controller.dart';
import 'package:task_manger/controllers/cancelled_task_controller.dart';
import 'package:task_manger/controllers/completed_task_controller.dart';
import 'package:task_manger/controllers/edit_profile_controller.dart';
import 'package:task_manger/controllers/forget_password_controller.dart';
import 'package:task_manger/controllers/login_controller.dart';
import 'package:task_manger/controllers/new_task_controller.dart';
import 'package:task_manger/controllers/pin_verification_controller.dart';
import 'package:task_manger/controllers/progress_task_controller.dart';
import 'package:task_manger/controllers/reset_password_controller.dart';
import 'package:task_manger/controllers/sign_up_controller.dart';
import 'package:task_manger/controllers/task_count_controller.dart';
import 'package:task_manger/controllers/task_item_controller.dart';
import 'package:task_manger/ui/screens/splash_screen.dart';

class TaskMangerApp extends StatelessWidget {
  const TaskMangerApp({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigationKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(TaskCountController());
    Get.put(ProgressTaskController());
    Get.put(CompletedTaskController());
    Get.put(CancelledTaskController());
    Get.put(AddNewTaskController());
    Get.put(EditProfileController());
    Get.put(NavBarIndexController());
    Get.put(SignUpController());
    Get.put(ForgetPasswordController());
    Get.put(PinVerificationController());
    Get.put(ResetPasswordController());
    Get.put(TaskItemController());
  }
}
