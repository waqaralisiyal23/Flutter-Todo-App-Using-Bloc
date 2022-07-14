import 'package:flutter/material.dart';
import 'package:todoappusingbloc/models/task.dart';

enum MenuAction { edit, bookmark, delete, restore }

class TaskPopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback editCallback;
  final VoidCallback restoreCallback;

  const TaskPopupMenu({
    Key? key,
    required this.task,
    required this.cancelOrDeleteCallback,
    required this.likeOrDislikeCallback,
    required this.editCallback,
    required this.restoreCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (value) {
        switch (value) {
          case MenuAction.edit:
            editCallback();
            break;
          case MenuAction.bookmark:
            likeOrDislikeCallback();
            break;
          case MenuAction.delete:
            cancelOrDeleteCallback();
            break;
          case MenuAction.restore:
            restoreCallback();
            break;
        }
      },
      itemBuilder: task.isDeleted == false
          ? (context) => _getPopupItems()
          : (context) => _getPopupItemsForBin(),
    );
  }

  List<PopupMenuItem<MenuAction>> _getPopupItems() {
    return [
      PopupMenuItem(
        value: MenuAction.edit,
        child: TextButton.icon(
          onPressed: null,
          icon: const Icon(Icons.edit),
          label: const Text('Edit'),
        ),
      ),
      PopupMenuItem(
        value: MenuAction.bookmark,
        child: TextButton.icon(
          onPressed: null,
          icon: task.isFavorite == false
              ? const Icon(Icons.bookmark_add_outlined)
              : const Icon(Icons.bookmark_remove),
          label: task.isFavorite == false
              ? const Text('Add to Bookmarks')
              : const Text('Remove from\nBookmarks'),
        ),
      ),
      PopupMenuItem(
        value: MenuAction.delete,
        child: TextButton.icon(
          onPressed: null,
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
        ),
      ),
    ];
  }

  List<PopupMenuItem<MenuAction>> _getPopupItemsForBin() {
    return [
      PopupMenuItem(
        value: MenuAction.restore,
        child: TextButton.icon(
          onPressed: null,
          icon: const Icon(Icons.restore_from_trash),
          label: const Text('Restore'),
        ),
      ),
      PopupMenuItem(
        value: MenuAction.delete,
        child: TextButton.icon(
          onPressed: null,
          icon: const Icon(Icons.delete_forever),
          label: const Text('Delete Forever'),
        ),
      ),
    ];
  }
}
