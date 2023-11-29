import 'package:flutter/material.dart';
import 'package:task_manger/app.dart';
import 'package:task_manger/controllers/auth_controller.dart';
import 'package:task_manger/ui/screens/edit_profile_screen.dart';
import 'package:task_manger/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({super.key, this.enableOnTap = true});
  final bool enableOnTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (enableOnTap) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ),
          );
        }
      },
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        fullName,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(AuthController.user?.email ?? '',
          style: const TextStyle(
            color: Colors.white,
          )),
      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearAuthData();
          //todo - fix error
          Navigator.pushAndRemoveUntil(
            TaskMangerApp.navigationKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        },
        icon: const Icon(Icons.logout),
      ),
      tileColor: Colors.green,
    );
  }

  String get fullName {
    return '${AuthController.user?.firstName ?? ''}'
        ' '
        '${AuthController.user?.lastName ?? ''}';
  }
}