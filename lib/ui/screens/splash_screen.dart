import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manger/controllers/auth_controller.dart';
import 'package:task_manger/ui/screens/login_screen.dart';
import 'package:task_manger/ui/screens/main_bottom_nav_screen.dart';

import '../widgets/body_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToLogin();
    super.initState();
  }

  void goToLogin() async {
    final bool isLoggedIn = await Get.find<AuthController>().checkAuthState();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.offAll(
        () => isLoggedIn ? const MainBottomNavScreen() : const LoginScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: SvgPicture.asset(
            'assets/images/logo.svg',
          ),
        ),
      ),
    );
  }
}
