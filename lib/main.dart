// Import the necessary packages
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      home: ToDoScreen(),
    );
  }
}

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<ToDoItem> toDoList = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int currentlyEditedIndex =
      -1; // Initially set to -1, meaning no item is being edited

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        primary: false,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.search,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    addTodoItem(
                      titleController.text,
                      descriptionController.text,
                    );
                    titleController.clear();
                    descriptionController.clear();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: toDoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.grey[300],
                    leading: const CircleAvatar(
                      //radius: 20,
                      backgroundColor: Colors.red,
                    ),
                    title: Text(
                      // Dynamically show the edited or original title
                      currentlyEditedIndex == index
                          ? toDoList[index].title
                          : toDoList[index].title,
                    ),
                    subtitle: Text(
                      // Dynamically show the edited or original description
                      currentlyEditedIndex == index
                          ? toDoList[index].description
                          : toDoList[index].description,
                    ),
                    onLongPress: () {
                      showEditDeleteDialog(index);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.white,
                    height: 10,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addTodoItem(String title, String description) {
    setState(() {
      toDoList.add(ToDoItem(title, description));
    });
  }

  void showEditDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('What would you like to do with this item?'),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                currentlyEditedIndex = index;
                Navigator.pop(context);
                showEditModalBottomSheet(index);
              },
              child: const Text(
                'Edit',
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                deleteTodoItem(index);
                Navigator.pop(context);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void showEditModalBottomSheet(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: toDoList[index].title),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    toDoList[index].title = value; // Update the title
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller:
                    TextEditingController(text: toDoList[index].description),
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    toDoList[index].description =
                        value; // Update the description
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                  currentlyEditedIndex = -1; // Reset the currently edited index
                },
                child: const Text('Edit Done'),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        );
      },
    );
  }

  void deleteTodoItem(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }
}

class ToDoItem {
  String title;
  String description;

  ToDoItem(this.title, this.description);
}
