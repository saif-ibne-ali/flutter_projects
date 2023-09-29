import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';

/// responsive Layout builder: responsive_builder
/// Device preview : device_preview
/// Size (height, width) : Sizer

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Responsive Design"),
        centerTitle: true,
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return Center(
            child: Text(
              sizingInformation.deviceScreenType.toString(),
              style: TextStyle(fontSize: 15.sp),
            ),
          );
        },
      ),
    );
  }
}
