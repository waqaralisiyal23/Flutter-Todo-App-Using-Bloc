import 'package:flutter/material.dart';
import 'package:todoappusingbloc/blocs/bloc_exports.dart';
import 'package:todoappusingbloc/screens/recycle_bin_screen.dart';
import 'package:todoappusingbloc/screens/tabs_screen.dart';

class TaskDrawer extends StatelessWidget {
  const TaskDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Text(
                'Task Drawer',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, tasksState) {
                return ListTile(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(TabsScreen.name),
                  leading: const Icon(Icons.folder_special),
                  title: const Text('My Tasks'),
                  trailing: Text(
                    '${tasksState.pendingTasks.length.toString()} | '
                    '${tasksState.completedTasks.length.toString()}',
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, tasksState) {
                return ListTile(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(RecycleBinScreen.name),
                  leading: const Icon(Icons.delete),
                  title: const Text('Bin'),
                  trailing: Text(tasksState.removedTasks.length.toString()),
                );
              },
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, switchState) {
                return ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Dark Mode'),
                  trailing: Switch(
                    value: switchState.switchValue,
                    onChanged: (newValue) {
                      newValue
                          ? context.read<SwitchBloc>().add(SwitchOnEvent())
                          : context.read<SwitchBloc>().add(SwitchOffEvent());
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
