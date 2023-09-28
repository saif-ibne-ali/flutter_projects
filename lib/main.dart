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
    return Scaffold(
        appBar: AppBar(
          title: const Text("AspectRatio & Flexible"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            //Ratio = Width/Height
            // AspectRatio(
            //   aspectRatio: 16 / 16,
            //   child: Container(
            //     color: Colors.red,
            //     child: Image.network(
            //       "https://images.idgesg.net/images/article/2017/10/wireless_network_internet_of_things_iot_thinkstock_853701554_3x2-100740688-large.jpg?auto=webp&quality=85,70",
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),


            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.width,
            //   color: Colors.amber,
            //   child: FractionallySizedBox(
            //     widthFactor: 0.5,
            //     heightFactor: 0.5,
            //     alignment: Alignment.topLeft,
            //     child: Container(
            //       color: Colors.green,
            //
            //     ),
            //   ),
            // )


            Flexible(
                fit:FlexFit.tight,
                flex: 3,
                child: Container(
                  color: Colors.deepPurple,
                  width: MediaQuery.of(context).size.width,
                )),
            Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: Container(
                  color: Colors.deepOrange,
                  width: MediaQuery.of(context).size.width,
                )),
            const SizedBox(height: 50,),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                Flexible(
                  child: Container(
                  color: Colors.lightBlueAccent,
                  ),
                ),
                Flexible(
                  child: Container(
                  color: Colors.blue,
                  ),
                ),
              ],
            ),
            ),
          ],
        ));
  }
}
