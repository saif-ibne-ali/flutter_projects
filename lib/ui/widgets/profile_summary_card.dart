import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/controllers/auth_controller.dart';
import 'package:task_manger/ui/screens/edit_profile_screen.dart';
import 'package:task_manger/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({super.key, this.enableOnTap = true});
  final bool enableOnTap;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      String base64String = authController.user?.photo ?? '';
      if (base64String.startsWith('data:image')) {
        base64String =
            base64String.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
      }
      Uint8List imageBytes = const Base64Decoder().convert(base64String);
      return ListTile(
        onTap: () {
          if (enableOnTap) {
            Get.off(() => const EditProfileScreen());
          }
        },
        leading: CircleAvatar(
          child: authController.user?.photo == null
              ? const Icon(Icons.person)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.memory(
                    imageBytes,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        title: Text(
          fullName(authController),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(authController.user?.email ?? '',
            style: const TextStyle(
              color: Colors.white,
            )),
        trailing: IconButton(
          onPressed: () async {
            await authController.clearAuthData();
            Get.offAll(const LoginScreen());
          },
          icon: const Icon(Icons.logout),
        ),
        tileColor: Colors.green,
      );
    });
  }

  String fullName(AuthController authController) {
    return '${authController.user?.firstName ?? ''}'
        ' '
        '${authController.user?.lastName ?? ''}';
  }
}
