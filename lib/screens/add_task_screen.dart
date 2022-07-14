import 'package:flutter/material.dart';
import 'package:todoappusingbloc/blocs/bloc_exports.dart';
import 'package:todoappusingbloc/models/task.dart';
import 'package:todoappusingbloc/services/guid_gen.dart';

class AddTaskScreenArguments {
  final String title;
  final Task? oldTask;

  AddTaskScreenArguments({
    required this.title,
    this.oldTask,
  });
}

class AddTaskScreen extends StatefulWidget {
  final String title;
  final Task? oldTask;
  const AddTaskScreen({
    Key? key,
    required this.title,
    this.oldTask,
  }) : super(key: key);
  static const name = 'add_task_screen';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    if (widget.oldTask != null) {
      titleController.text = widget.oldTask!.title;
      descriptionController.text = widget.oldTask!.description;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: descriptionController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isNotEmpty &&
                        descriptionController.text.trim().isNotEmpty) {
                      FocusScope.of(context).unfocus();
                      if (widget.oldTask == null) {
                        Task task = Task(
                          id: GUIDGen.generate(),
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          date: DateTime.now().toString(),
                        );
                        context.read<TasksBloc>().add(AddTask(task: task));
                      } else {
                        Task editedTask = Task(
                          id: widget.oldTask!.id,
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          isDone: false,
                          isFavorite: widget.oldTask!.isFavorite,
                          date: DateTime.now().toString(),
                        );
                        context.read<TasksBloc>().add(EditTask(
                              oldTask: widget.oldTask!,
                              newTask: editedTask,
                            ));
                      }
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(const Size(
                      200,
                      40,
                    )),
                  ),
                  child: Text(
                    widget.oldTask == null ? 'Add' : 'Save',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
