import 'package:flutter/material.dart';
import 'package:todoappusingbloc/blocs/bloc_exports.dart';
import 'package:todoappusingbloc/models/task.dart';
import 'package:todoappusingbloc/screens/views/tasks_list.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, tasksState) {
        List<Task> tasksList = tasksState.completedTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  '${tasksList.length} Tasks',
                ),
              ),
            ),
            TasksList(tasksList: tasksList),
          ],
        );
      },
    );
  }
}
