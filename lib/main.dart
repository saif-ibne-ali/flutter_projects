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

  mySnackBar(message, context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
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
                  hintText: 'Search for photos...'),
            ),
          ),
          GridView.count(
            padding: const EdgeInsets.all(10.0),
            crossAxisCount: 3,
            shrinkWrap: true,
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      mySnackBar("Photo 0", context);
                    },
                    child: Column(
                      children: [
                        Image.network(
                          "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        ),
                        const Text(
                          "Photo 0",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      mySnackBar("Photo 1", context);
                    },
                    child: Column(
                      children: [
                        Image.network(
                          "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        ),
                        const Text(
                          "Photo 1",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      mySnackBar("Photo 2", context);
                    },
                    child: Column(
                      children: [
                        Image.network(
                          "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        ),
                        const Text(
                          "Photo 2",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      mySnackBar("Photo 3", context);
                    },
                    child: Column(
                      children: [
                        Image.network(
                          "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        ),
                        const Text(
                          "Photo 3",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      mySnackBar("Photo 4", context);
                    },
                    child: Column(
                      children: [
                        Image.network(
                          "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        ),
                        const Text(
                          "Photo 4",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      mySnackBar("Photo 5", context);
                    },
                    child: Column(
                      children: [
                        Image.network(
                          "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        ),
                        const Text(
                          "Photo 5",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  )),
            ],
          ),
          const ListTile(
            title: Text("Photo 1"),
            subtitle: Text("Description for photo 1"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
              radius: 20,
            ),
          ),
          const ListTile(
            title: Text("Photo 2"),
            subtitle: Text("Description for photo 2"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
              radius: 20,
            ),
          ),
          const ListTile(
            title: Text("Photo 3"),
            subtitle: Text("Description for photo 3"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
              radius: 20,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            onPressed: () {
              mySnackBar("Photos Uploaded Successfully!", context);
            },
            child: const Icon(
              Icons.upload,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
