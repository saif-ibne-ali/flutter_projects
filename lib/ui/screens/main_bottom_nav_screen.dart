import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/controllers/bottom_navigation_bar_controller.dart';
import 'package:task_manger/ui/screens/cancelled_task_screen.dart';
import 'package:task_manger/ui/screens/completed_task_screen.dart';
import 'package:task_manger/ui/screens/new_task_screen.dart';
import 'package:task_manger/ui/screens/progress_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screens = [
    const NewTaskScreen(),
    const ProgressTaskScreen(),
    const CompletedTaskScreen(),
    const CancelledTaskScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarIndexController>(builder: (navBarIndexController) {
      return Scaffold(
        body: _screens[navBarIndexController.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navBarIndexController.selectedIndex,
          onTap: (index) {
            navBarIndexController.getSelectedIndex(index);
          },
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.new_label), label: 'New'),
            BottomNavigationBarItem(
                icon: Icon(Icons.run_circle), label: 'In Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
            BottomNavigationBarItem(
                icon: Icon(Icons.cancel), label: 'Cancelled'),
          ],
        ),
      );
    });
  }
}
