import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Module 5 Assignment',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          elevation: 70,
          centerTitle: true,
          title: Text(title),
          leading: const Icon(Icons.add_business),
          actions: const [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10.0),
              onPressed: null,
            ),
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This is mod 5 Assignment\n',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'My ',
                  style: TextStyle(color: Colors.red.shade300, fontSize: 20),
                ),
                Text(
                  'phone ',
                  style: TextStyle(color: Colors.blue.shade300),
                ),
                Text(
                  'name ',
                  style: TextStyle(
                      color: Colors.pink.shade300, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Your phone name',
                  style: TextStyle(color: Colors.amber.shade700, fontSize: 22),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
