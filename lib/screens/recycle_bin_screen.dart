import 'package:flutter/material.dart';
import 'package:todoappusingbloc/blocs/bloc_exports.dart';
import 'package:todoappusingbloc/models/task.dart';
import 'package:todoappusingbloc/screens/views/task_drawer.dart';
import 'package:todoappusingbloc/screens/views/tasks_list.dart';

class RecycleBinScreen extends StatelessWidget {
  const RecycleBinScreen({Key? key}) : super(key: key);
  static const name = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, tasksState) {
        List<Task> removedTasksLists = tasksState.removedTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () =>
                        context.read<TasksBloc>().add(DeleteAllTasks()),
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Delete all tasks'),
                    ),
                  )
                ],
              ),
            ],
          ),
          drawer: const TaskDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    '${removedTasksLists.length} Tasks',
                  ),
                ),
              ),
              TasksList(tasksList: removedTasksLists),
            ],
          ),
        );
      },
    );
  }
}
