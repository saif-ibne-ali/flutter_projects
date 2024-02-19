import 'package:crafty_bay/data/models/profile_model.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/complete_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/read_profile_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateShippingInfo extends StatefulWidget {
  const UpdateShippingInfo({super.key, required this.profile});

  final ProfileModel profile;

  @override
  State<UpdateShippingInfo> createState() => _UpdateShippingInfoState();
}

class _UpdateShippingInfoState extends State<UpdateShippingInfo> {
  TextEditingController _stateTEController = TextEditingController();
  TextEditingController _postCodeTEController = TextEditingController();
  TextEditingController _nameTEController = TextEditingController();
  TextEditingController _countryTEController = TextEditingController();
  TextEditingController _mobileTEController = TextEditingController();
  TextEditingController _cityTEController = TextEditingController();
  TextEditingController _addressTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _stateTEController = TextEditingController(text: widget.profile.shipState!);
    _postCodeTEController =
        TextEditingController(text: widget.profile.shipPostcode!);
    _nameTEController = TextEditingController(text: widget.profile.shipName!);
    _countryTEController =
        TextEditingController(text: widget.profile.shipCountry!);
    _mobileTEController =
        TextEditingController(text: widget.profile.shipPhone!);
    _cityTEController = TextEditingController(text: widget.profile.shipCity!);
    _addressTEController = TextEditingController(text: widget.profile.shipAdd!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Your Shipping information'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  decoration: const InputDecoration(label: Text('Name')),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _addressTEController,
                  decoration: const InputDecoration(label: Text('Address')),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cityTEController,
                  decoration: const InputDecoration(label: Text('City')),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter city';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _stateTEController,
                  decoration: const InputDecoration(label: Text('State')),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter state';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _postCodeTEController,
                  decoration: const InputDecoration(label: Text('PostCode')),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter postcode';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _countryTEController,
                  decoration: const InputDecoration(label: Text('Country')),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter mobile';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _mobileTEController,
                  decoration: const InputDecoration(label: Text('Mobile')),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter mobile';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                    width: double.infinity,
                    child: GetBuilder<CompleteProfileController>(
                        builder: (completeProfileController) {
                      return Visibility(
                        visible: completeProfileController.inProgress == false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                bool response = await completeProfileController
                                    .createProfile(
                                        AuthController.token!,
                                        ProfileModel(
                                            shipName: _nameTEController.text
                                                .trim(),
                                            shipAdd: _addressTEController.text
                                                .trim(),
                                            shipCity: _cityTEController.text
                                                .trim(),
                                            shipState:
                                                _stateTEController.text.trim(),
                                            shipPostcode: _postCodeTEController
                                                .text
                                                .trim(),
                                            shipCountry: _countryTEController
                                                .text
                                                .trim(),
                                            shipPhone: _mobileTEController.text
                                                .trim()));
                                if (response) {
                                  Get.find<ReadProfileController>()
                                      .readProfileData(AuthController.token!);
                                  Get.back();
                                }
                              }
                            },
                            child: const Text('Update')),
                      );
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
