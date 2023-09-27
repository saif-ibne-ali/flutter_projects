import 'package:flutter/material.dart';

class CartList extends StatelessWidget {
  final List<String> itemName;
  final List<int> itemCount;

  const CartList({super.key, required this.itemName, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                itemCount.clear();
                itemName.clear();
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Cart"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(20.0),
              color: Theme.of(context).colorScheme.inversePrimary,
              child: Text(
                "Total Products ${itemName.length}",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: itemName.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(itemName[index]),
                      subtitle: const Text("\$20.0"),
                      trailing: Text("Count: ${itemCount[index]}"));
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        itemCount.clear();
        itemName.clear();
        return true;
      },
    );
  }
}
