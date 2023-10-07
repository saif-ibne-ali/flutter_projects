import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Module8 Assignment",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  //color: Colors.green,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My Bag",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              Flexible(
                flex: 16,
                fit: FlexFit.loose,
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, index) {
                      return SizedBox(
                        height: 100,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Image.network(
                                    "https://images.unsplash.com/photo-1490650034439-fd184c3c86a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXwxNDk0OTAwfHxlbnwwfHx8fHw%3D&w=1000&q=80"),
                              ),
                              Flexible(
                                flex: 3,
                                child: ListTile(
                                  //contentPadding: EdgeInsets.all(0.0),
                                  //leading: AspectRatio(
                                  //  aspectRatio: 1,
                                  //  child: Image.network(
                                  //      "https://images.unsplash.com/photo-1490650034439-fd184c3c86a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXwxNDk0OTAwfHxlbnwwfHx8fHw%3D&w=1000&q=80"),
                                  // ),
                                  title: const Text(
                                    "T-Shirt",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Color: "),
                                          RichText(
                                            text: const TextSpan(
                                                text: "Black",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text("Size: "),
                                          RichText(
                                            text: const TextSpan(
                                                text: "L",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  color: Colors.black,
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ));
  }
}
