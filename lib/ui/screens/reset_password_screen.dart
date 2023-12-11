import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/controllers/reset_password_controller.dart';
import 'package:task_manger/ui/screens/login_screen.dart';
import 'package:task_manger/ui/widgets/body_background.dart';
import 'package:task_manger/ui/widgets/show_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, required this.email, required this.otp});
  final String email;
  final String otp;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final ResetPasswordController _resetPasswordController =
      ResetPasswordController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Minimum Password length should be 8 letters',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a valid password';
                        }
                        if (value.length < 8) {
                          return 'Password should not be less than 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordTEController,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the confirm password';
                        } else if (value != _passwordTEController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<ResetPasswordController>(
                          builder: (resetPasswordController) {
                        return Visibility(
                          visible: resetPasswordController
                                  .isResetPasswordInProgress ==
                              false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: _getPasswordReset,
                            child: const Text('Confirm'),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have account?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                            onPressed: () => Get.off(() => const LoginScreen()),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getPasswordReset() async {
    if (_formkey.currentState!.validate()) {
      final response = await _resetPasswordController.getPasswordReset(
        widget.email,
        widget.otp,
        _confirmPasswordTEController.text,
      );

      if (response) {
        if (mounted) {
          showSnackMessage(context, _resetPasswordController.showMessage);
        }
        Get.offAll(() => const LoginScreen());
      } else {
        if (mounted) {
          showSnackMessage(context, _resetPasswordController.showMessage, true);
        }
      }
    }
  }

  @override
  void dispose() {
    _confirmPasswordTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
