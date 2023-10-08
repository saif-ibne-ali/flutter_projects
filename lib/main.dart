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
  List<int> price = [10, 20, 30];
  List<int> itemCounts = [0, 0, 0];
  int total = 0;

  itemIncrement(int index) {
    itemCounts[index] = itemCounts[index] + 1;
    setState(() {
      total = total + price[index];
    });
  }

  itemDecrement(int index) {
    if (itemCounts[index] > 0) {
      itemCounts[index] = itemCounts[index] - 1;
      setState(() {
        total = total - price[index];
      });
    }
  }

  mySnackBar(message, context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

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
                    itemCount: price.length,
                    itemBuilder: (BuildContext context, index) {
                      return SizedBox(
                        height: 140,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Image.network(
                                  "https://images.unsplash.com/photo-1490650034439-fd184c3c86a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXwxNDk0OTAwfHxlbnwwfHx8fHw%3D&w=1000&q=80",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: ListTile(
                                  title: const Text(
                                    "T-Shirt",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Wrap(
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
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
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                itemIncrement(index);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                  backgroundColor:
                                                      Colors.white),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              '${itemCounts[index]}',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                itemDecrement(index);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                  backgroundColor:
                                                      Colors.white),
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Stack(
                                    children: [
                                      const Positioned(
                                        top: 6,
                                        right: 0,
                                        child: Icon(Icons.more_vert),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        right: 10,
                                        child: Text(
                                          "\$${price[index]}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Stack(
                  children: [
                    const Positioned(
                      left: 0,
                      child: Text(
                        "Total amount:",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "\$$total",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: InkWell(
                  onTap: () {
                    mySnackBar("Congratualations!", context);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: const Center(child: Text("CHECK OUT")),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
