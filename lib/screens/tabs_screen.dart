import 'package:flutter/material.dart';
import 'package:todoappusingbloc/screens/add_task_screen.dart';
import 'package:todoappusingbloc/screens/views/completed_tasks.dart';
import 'package:todoappusingbloc/screens/views/favorite_tasks.dart';
import 'package:todoappusingbloc/screens/views/pending_tasks.dart';
import 'package:todoappusingbloc/screens/views/task_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const name = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedPageIndex = 0;

  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const PendingTasks(), 'title': 'Pending Tasks'},
    {'pageName': const CompletedTasks(), 'title': 'Completed Tasks'},
    {'pageName': const FavoriteTasks(), 'title': 'Favorite Tasks'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[selectedPageIndex]['title']),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              AddTaskScreen.name,
              arguments: AddTaskScreenArguments(title: 'Add Task'),
            ),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const TaskDrawer(),
      body: _pageDetails[selectedPageIndex]['pageName'],
      floatingActionButton: selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed(
                AddTaskScreen.name,
                arguments: AddTaskScreenArguments(title: 'Add Task'),
              ),
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPageIndex,
        onTap: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.incomplete_circle_sharp),
            label: 'Pending Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Completed Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite Tasks',
          ),
        ],
      ),
    );
  }
}
