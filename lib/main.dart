import 'package:flutter/material.dart';
import 'cart_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //int _counter = 0;

  List<String> productName = [
    "Dell Monitor",
    "MSI MotherBoard",
    "RAM 8GB",
    "RAM 4GB",
    "16GB Flash Drive",
    "Keyboard",
    "Mouse",
    "HP Monitor",
    "240GB SSD",
    "500GB HDD",
    "1TB HDD",
    "MI TV BOX",
    "Sony TV",
    "MicroLab Music"
  ];
  List<String> itemName = [];
  List<int> itemCount = [];

  List<int> productCount = List.generate(14, (int count) => 0);

  int _incrementCounter(int index) {
    setState(() {
      productCount[index]++;
    });
    //print(productCount);
    return productCount[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Product List"),
        centerTitle: true,
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: productName.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(productName[index]),
            subtitle: const Text("\$20.0"),
            trailing: Column(
              children: [
                Text("Counter: ${productCount[index]}"),
                ElevatedButton(
                  onPressed: () {
                    int tapCount = _incrementCounter(index);
                    if (tapCount == 5) {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Congratualations!"),
                              content:
                                  Text("You've bought $tapCount Products!"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"))
                              ],
                            );
                          });
                    }
                  },
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (int i = 0; i < productCount.length; i++) {
            if (productCount[i] != 0) {
              itemName.add(productName[i]);
              itemCount.add(productCount[i]);
            }
          }
          //print(itemName);
          //print(itemCount);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CartList(itemName: itemName, itemCount: itemCount);
          }));
        },
        tooltip: 'Go To Cart',
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
