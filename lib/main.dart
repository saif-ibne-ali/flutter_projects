import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Module 6 Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Photo Gallery'),
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
        //toolbarHeight: 100,
        //elevation: 70,
        centerTitle: true,
        title: Text(title),
        /*     leading: const Icon(Icons.add_business),
          actions: const [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10.0),
              onPressed: null,
            ),
          ] */
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              "Welcome to My Photo Gallery",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: const TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  //labelText: 'Enter Name',
                  hintText: 'Search for photos...'),
            ),
          ),
          GridView.count(
            padding: const EdgeInsets.all(10.0),
            //gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            shrinkWrap: true,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  height: 10.0,
                  width: 10.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  width: 10.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  width: 10.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  width: 10.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  width: 10.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  width: 10.0,
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
