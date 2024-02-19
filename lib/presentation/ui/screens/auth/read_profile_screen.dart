import 'package:crafty_bay/data/models/profile_model.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/read_profile_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/update_profile_info_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/update_shipping_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadProfileScreen extends StatefulWidget {
  const ReadProfileScreen({super.key});

  @override
  State<ReadProfileScreen> createState() => _ReadProfileScreenState();
}

class _ReadProfileScreenState extends State<ReadProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ReadProfileController>()
          .readProfileData(AuthController.token ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<ReadProfileController>(
              builder: (readProfileController) {
            ProfileModel profile = readProfileController.profile;
            return Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    profile.cusName ?? '',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    profile.user?.email ?? '',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.logout))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Profile Information',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(() => UpdateUserInfo(profile: profile));
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                          //height: 20,
                          thickness: 1,
                          //indent: 20,
                          //endIndent: 20,
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('Name :')),
                            Text(profile.cusName ?? '')
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('Address :')),
                            Text(profile.cusAdd ?? '')
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('City :')),
                            Text(profile.cusCity ?? ''),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('State :')),
                            Text(profile.cusState ?? '')
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('PostCode :')),
                            Text(profile.cusPostcode ?? '')
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('Country :')),
                            Text(profile.cusCountry ?? '')
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('Phone :')),
                            Text(profile.cusPhone ?? '')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Shipping Information',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(
                                    () => UpdateShippingInfo(profile: profile));
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                          //height: 20,
                          thickness: 1,
                          //indent: 20,
                          //endIndent: 20,
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('Name :')),
                            Text(profile.shipName ?? '')
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('Address :')),
                            Text(profile.shipAdd ?? '')
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('City :')),
                            Text(profile.shipCity ?? ''),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('State :')),
                            Text(profile.shipState ?? '')
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('PostCode :')),
                            Text(profile.shipPostcode ?? '')
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('Country :')),
                            Text(profile.shipCountry ?? '')
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('Phone :')),
                            Text(profile.shipPhone ?? '')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
