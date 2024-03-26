import 'package:flutter/material.dart';
import 'package:rest_api_crud_1/ui/screens/cancelled_tasks_screen.dart';
import 'package:rest_api_crud_1/ui/screens/completed_tasks_screen.dart';
import 'package:rest_api_crud_1/ui/screens/new_task_screen.dart';
import 'package:rest_api_crud_1/ui/screens/progress_tasks_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTasksScreen(),
    ProgressTasksScreen(),
    CompletedTasksScreen(),
    CancelledTasksScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        // ignore: non_constant_identifier_names
        onTap: (Index) {
          _selectedIndex = Index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'New'),
          BottomNavigationBarItem(
              icon: Icon(Icons.change_circle_rounded), label: 'Inprogress'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Cancelled'),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}











