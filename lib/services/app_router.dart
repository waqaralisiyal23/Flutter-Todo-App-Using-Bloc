import 'package:flutter/material.dart';
import 'package:todoappusingbloc/screens/add_task_screen.dart';
import 'package:todoappusingbloc/screens/recycle_bin_screen.dart';
import 'package:todoappusingbloc/screens/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case TabsScreen.name:
        return MaterialPageRoute(builder: (_) => const TabsScreen());
      case AddTaskScreen.name:
        final args = routeSettings.arguments as AddTaskScreenArguments;
        return MaterialPageRoute(
            builder: (_) => AddTaskScreen(
                  title: args.title,
                  oldTask: args.oldTask,
                ));
      case RecycleBinScreen.name:
        return MaterialPageRoute(builder: (_) => const RecycleBinScreen());
      default:
        return null;
    }
  }
}
