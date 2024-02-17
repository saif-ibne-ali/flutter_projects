import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Icon(
                              Icons.person,
                              size: 50,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Saiful Islam',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
                  ],
                ),
              ),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Profile Information',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      //height: 20,
                      thickness: 1,
                      //indent: 20,
                      //endIndent: 20,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Name :')),
                        Text('Saiful Islam')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Address :')),
                        Text('#322, Kanchan')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('City :')),
                        Text('Purbachal'),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('State :')),
                        Text('Dhaka')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('PostCode :')),
                        Text('1461')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Country :')),
                        Text('Bangladesh')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Phone :')),
                        Text('01701046867')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Shipping Information',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      //height: 20,
                      thickness: 1,
                      //indent: 20,
                      //endIndent: 20,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Name :')),
                        Text('Saiful Islam')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Address :')),
                        Text('#322, Kanchan')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('City :')),
                        Text('Purbachal'),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('State :')),
                        Text('Dhaka')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('PostCode :')),
                        Text('1461')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Country :')),
                        Text('Bangladesh')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Phone :')),
                        Text('01701046867')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
