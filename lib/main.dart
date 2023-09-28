import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediaQuery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size);
    print(size.width);
    print(size.height);
    print(size.aspectRatio);
    print(size.isEmpty);
    Orientation orientation = MediaQuery.of(context).orientation;
    print(orientation);
    List<DisplayFeature> displayFeatures =
        MediaQuery.of(context).displayFeatures;
    print(displayFeatures);
    print(MediaQuery.of(context).devicePixelRatio);
    print(MediaQuery.platformBrightnessOf(context));

    return Scaffold(
      appBar: AppBar(
        title: const Text("MediaQuery"),
        centerTitle: true,
      ),
      body: Container(
        height: size.height / 2,
        width: size.width / 2,
        color: Colors.blueAccent,
      ),
    );
  }
}
