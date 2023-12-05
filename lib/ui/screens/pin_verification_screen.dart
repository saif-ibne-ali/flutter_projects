import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';
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
  String enteredPin = '';
  late String otp;
  bool _isPinVerifyInProgress = false;
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
                        setState(() {
                          enteredPin = value;
                        });
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
                      child: Visibility(
                        visible: _isPinVerifyInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: enteredPin.length == 6
                              ? () {
                                  getPinVerify();
                                }
                              : null,
                          child: const Text('Verify'),
                        ),
                      ),
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
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                ModalRoute.withName('/'),
                              );
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

  Future<void> getPinVerify() async {
    if (_formKey.currentState!.validate()) {
      _isPinVerifyInProgress = true;
      if (mounted) {
        setState(() {});
      }
      NetworkResponse response = await NetworkCaller().getRequest(
        Urls.recoverVerifyOTP(widget.email, otp),
      );
      _isPinVerifyInProgress = true;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        if (mounted) {
          showSnackMessage(context, 'Verification Successful');
        }
        Future.delayed(const Duration(seconds: 2)).then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(
                  email: widget.email,
                  otp: otp,
                ),
              ),
              (route) => false);
        });
      } else {
        if (mounted) {
          showSnackMessage(context, 'Something Wrong. Try again.');
        }
      }
    }
  }
}
