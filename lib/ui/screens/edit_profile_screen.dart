import 'package:flutter/material.dart';
import 'package:task_manger/controllers/auth_controller.dart';
import 'package:task_manger/data/network_caller/network_caller.dart';
import 'package:task_manger/data/network_caller/network_response.dart';
import 'package:task_manger/data/utility/urls.dart';
import 'package:task_manger/ui/widgets/body_background.dart';
import 'package:task_manger/ui/widgets/profile_summary_card.dart';
import 'package:task_manger/ui/widgets/show_message.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool _updateProfileInProgress = false;

  @override
  void initState() {
    _emailTEController.text = AuthController.user?.email ?? '';
    _firstNameTEController.text = AuthController.user?.firstName ?? '';
    _lastNameTEController.text = AuthController.user?.lastName ?? '';
    _mobileTEController.text = AuthController.user?.mobile ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const ProfileSummaryCard(
            enableOnTap: false,
          ),
          Expanded(
              child: BodyBackground(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      'Update Profile',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    photoPickerField(),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _mobileTEController,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordTEController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _updateProfileInProgress == true,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: updateProfile,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ))
        ],
      )),
    );
  }

  Future<void> updateProfile() async {
    _updateProfileInProgress = true;

    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> inputData = {
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "email": _emailTEController.text.trim(),
      "mobile": _mobileTEController.text.trim()
    };

    if (_passwordTEController.text.isNotEmpty) {
      inputData['password'] = _passwordTEController.text;
    }

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.updateProfile,
      body: inputData,
    );
    _updateProfileInProgress = false;
    if (response.isSuccess) {
      if (mounted) {
        showSnackMessage(context, 'Update profile Success!');
      }
    } else {
      if (mounted) {
        showSnackMessage(context, 'Update profile failed! Try again');
      }
    }
  }

  Container photoPickerField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text('empty'),
            ),
          )
        ],
      ),
    );
  }
}
