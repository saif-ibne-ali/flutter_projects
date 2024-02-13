import 'dart:async';

import 'package:crafty_bay/presentation/state_holders/validate_email_controller.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.email});

  final String email;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  //final TextEditingController _otpTEController = TextEditingController();
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _enteredPin = '';
  late String _otp;
  late Timer _timer;
  int _countdownSeconds = 120;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _otp;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              const AppLogo(
                height: 80,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Enter OTP Code',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'A 4 digit OTP code has been sent to ${widget.email}',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 24,
              ),
              PinCodeTextField(
                //controller: _otpTEController,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.transparent,
                    inactiveFillColor: Colors.transparent,
                    inactiveColor: AppColors.primaryColor,
                    selectedFillColor: Colors.transparent,
                    selectedColor: Colors.purple),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                onChanged: (value) {
                  setState(() {});
                  _enteredPin = value;
                },
                beforeTextPaste: (text) {
                  return RegExp(r'^[0-9]+$').hasMatch(text!);
                },
                onCompleted: (value) {
                  _otp = value;
                },
                appContext: context,
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: GetBuilder<VerifyOTPController>(
                    builder: (verifyOtpController) {
                  return Visibility(
                    visible: verifyOtpController.inProgress == false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _enteredPin.length == 6 &&
                              _countdownSeconds != 0
                          ? () async {
                              final bool response = await verifyOtpController
                                  .verifyOTP(widget.email, _otp);
                              if (response) {
                                if (verifyOtpController
                                    .doNavigateCompleteProfile) {
                                  Get.to(() => const CompleteProfileScreen());
                                } else {
                                  Get.offAll(() => const MainBottomNavScreen());
                                }
                              } else {
                                Get.showSnackbar(GetSnackBar(
                                  title: 'OTP verification failed',
                                  message: verifyOtpController.errorMessage,
                                  duration: const Duration(seconds: 2),
                                  isDismissible: true,
                                ));
                              }
                            }
                          : null,
                      child: const Text('Next'),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 24,
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  children: [
                    const TextSpan(text: 'This code will expire in '),
                    TextSpan(
                      text: '${_countdownSeconds}s',
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _countdownSeconds == 0
                    ? () async {
                        _countdownSeconds = 120;
                        startTimer();
                        await Get.find<ValidateEmailController>()
                            .sendOtpEmail(widget.email);
                      }
                    : null,
                child: Text(
                  'Resend Code',
                  style: TextStyle(
                      color: _countdownSeconds == 0
                          ? AppColors.primaryColor
                          : Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownSeconds == 0) {
          timer.cancel();
        } else {
          _countdownSeconds--;
        }
      });
    });
  }
}
