import 'package:flutter/material.dart';

class ProtraitView extends StatelessWidget {
  const ProtraitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 5,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1490650034439-fd184c3c86a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXwxNDk0OTAwfHxlbnwwfHx8fHw%3D&w=1000&q=80")),
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: ListTile(
            title: Text(
              "Saiful Islam\n",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: GridView.builder(
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return FractionallySizedBox(
                heightFactor: 0.9,
                widthFactor: 0.9,
                child: Container(
                  color: Colors.amber,
                  child: Image.network(
                      "https://images.unsplash.com/photo-1490650034439-fd184c3c86a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXwxNDk0OTAwfHxlbnwwfHx8fHw%3D&w=1000&q=80"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class LandscapeView extends StatelessWidget {
  const LandscapeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1490650034439-fd184c3c86a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXwxNDk0OTAwfHxlbnwwfHx8fHw%3D&w=1000&q=80")),
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: Column(
            children: [
              const Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: ListTile(
                  title: Text(
                    "Saiful Islam\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return FractionallySizedBox(
                      heightFactor: 0.9,
                      widthFactor: 0.9,
                      child: Container(
                        color: Colors.amber,
                        child: Image.network(
                            "https://images.unsplash.com/photo-1490650034439-fd184c3c86a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXwxNDk0OTAwfHxlbnwwfHx8fHw%3D&w=1000&q=80"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
