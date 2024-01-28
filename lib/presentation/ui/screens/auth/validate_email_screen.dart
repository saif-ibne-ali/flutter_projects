import 'package:crafty_bay/presentation/state_holders/validate_email_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/verify_otp_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidateEmailScreen extends StatefulWidget {
  const ValidateEmailScreen({super.key});

  @override
  State<ValidateEmailScreen> createState() => _ValidateEmailScreenState();
}

class _ValidateEmailScreenState extends State<ValidateEmailScreen> {

  final TextEditingController _emailTEController  = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 160,
                ),
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Please enter your email address',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailTEController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter Your Email';
                    }
                    RegExp emailRegEx = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                    if(!emailRegEx.hasMatch(value!.trim())){
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                GetBuilder<ValidateEmailController>(
                  builder: (controller) {
                    return SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: controller.inProgress == false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate()){
                              final bool result = await controller.sendOtpEmail(_emailTEController.text.trim());
                              if(result){
                                Get.to(()=>VerifyOTPScreen(email: _emailTEController.text.trim()));
                              } else {
                                Get.showSnackbar(GetSnackBar(
                                  isDismissible: true,
                                  title: 'Send OTP failed',
                                  message: controller.errorMessage,
                                  duration: const Duration(seconds: 5),
                                ));
                              }
                            }
                          },
                          child: const Text('Next'),
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
