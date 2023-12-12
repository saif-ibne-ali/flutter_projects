import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manger/controllers/pin_verification_controller.dart';
import 'package:task_manger/ui/screens/login_screen.dart';
import 'package:task_manger/ui/screens/reset_password_screen.dart';
import 'package:task_manger/ui/widgets/body_background.dart';
import 'package:task_manger/ui/widgets/show_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});

  final String email;
  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RxString enteredPin = ''.obs;
  late String otp;
  final PinVerificationController _pinVerificationController =
      PinVerificationController();
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
                      'Pin Verification',
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
                    PinCodeTextField(
                      keyboardType: TextInputType.number,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        activeColor: Colors.green,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      //backgroundColor: Colors.blue.shade50,
                      enableActiveFill: true,
                      onCompleted: (value) {
                        otp = value;
                      },
                      onChanged: (value) {
                        enteredPin.value = value;
                      },
                      beforeTextPaste: (text) {
                        return RegExp(r'^[0-9]+$').hasMatch(text!);
                      },
                      appContext: context,
                      validator: (value) {
                        if (value?.length != 6) {
                          return 'PIN must be 6 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<PinVerificationController>(
                          builder: (pinVerificationController) {
                        return Visibility(
                          visible:
                              pinVerificationController.isPinVerifyInProgress ==
                                  false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: enteredPin.value.length == 6
                                ? () {
                                    _getPinVerify();
                                  }
                                : null,
                            child: const Text('Verify'),
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

  Future<void> _getPinVerify() async {
    if (_formKey.currentState!.validate()) {
      final response =
          await _pinVerificationController.getPinVerify(widget.email, otp);

      if (response) {
        if (mounted) {
          showSnackMessage(context, _pinVerificationController.showMessage);
        }

        Get.offAll(() => ResetPasswordScreen(
              email: widget.email,
              otp: otp,
            ));
      } else {
        if (mounted) {
          showSnackMessage(
              context, _pinVerificationController.showMessage, true);
        }
      }
    }
  }
}
