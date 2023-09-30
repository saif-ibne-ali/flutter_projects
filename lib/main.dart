import 'package:flutter/material.dart';
import 'package:module6_assignment/view.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return const MaterialApp(
      title: "Module8 Assignment",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: ProtraitView(),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(5.0),
              child: LandscapeView(),
            );
          }
        },
      ),
    );
  }
}
