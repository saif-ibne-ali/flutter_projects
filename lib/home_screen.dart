import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Responsive Design"),
      ),
      body: Center(
        child: Stack(children: [
          Container(
            width: 300,
            height: 300,
            color: Colors.pink.shade200,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.green,
                  ),
                  Positioned(
                    //bottom: 0,
                    top: 0,
                    left: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      color: Colors.amber,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 10,
            child: Container(
              width: 30,
              height: 30,
              color: Colors.teal,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 30,
              width: 30,
              color: Colors.black,
            ),
          )
        ]),
      ),
    );
  }
}
