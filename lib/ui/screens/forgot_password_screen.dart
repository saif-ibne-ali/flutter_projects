import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/controllers/forget_password_controller.dart';
import 'package:task_manger/ui/screens/login_screen.dart';
import 'package:task_manger/ui/screens/pin_verification_screen.dart';
import 'package:task_manger/ui/widgets/body_background.dart';
import 'package:task_manger/ui/widgets/show_message.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ForgetPasswordController _forgetPasswordController =
      ForgetPasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Your Email Address',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'A 6 digit OTP will be sent to your email address for reset password',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value) {
                        if (!EmailValidator.validate(value ?? '')) {
                          return 'Enter valid Email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<ForgetPasswordController>(
                          builder: (forgetPasswordController) {
                        return Visibility(
                          visible:
                              forgetPasswordController.verifyEmailInProgress ==
                                  false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                              onPressed: _getVerifyEmail,
                              child: const Icon(Icons.arrow_forward)),
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
                            onPressed: () {
                              Get.offAll(() => const LoginScreen());
                            },
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

  Future<void> _getVerifyEmail() async {
    if (_formKey.currentState!.validate()) {
      final response = await _forgetPasswordController.getVerifyEmail(
        _emailTEController.text.trim(),
      );

      if (response) {
        if (mounted) {
          showSnackMessage(context, _forgetPasswordController.showMessage);
        }
        Get.off(
            () => PinVerificationScreen(email: _emailTEController.text.trim()));
      } else {
        if (mounted) {
          showSnackMessage(
              context, _forgetPasswordController.showMessage, true);
        }
      }
    }
  }
}
