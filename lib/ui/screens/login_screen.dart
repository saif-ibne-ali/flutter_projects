import 'package:flutter/material.dart';
import 'package:task_manger/controllers/auth_controller.dart';
import 'package:task_manger/data/model/user_model.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';
import 'package:task_manger/ui/screens/forgot_password_screen.dart';
import 'package:task_manger/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manger/ui/screens/sign_up_screen.dart';
import 'package:task_manger/ui/widgets/body_background.dart';
import 'package:task_manger/ui/widgets/show_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginProgress = false;

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
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter valid password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _loginProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: _login,
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.green.shade300,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
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

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _loginProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller().postRequest(Urls.login,
        body: {
          'email': _emailTEController.text.trim(),
          'password': _passwordTEController.text,
        },
        isLogin: true);
    _loginProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      await AuthController.saveUserInformation(response.jsonResponse?['token'],
          UserModel.fromJson(response.jsonResponse?['data']));

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNavScreen(),
          ),
        );
      }
    } else {
      if (response.statusCode == 401) {
        if (mounted) {
          showSnackMessage(context, 'Please check your email or password');
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'login failed! Try again');
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();

    super.dispose();
  }
}
