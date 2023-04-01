import 'package:flutter/material.dart';
import 'package:simple_todo_list/app/theme/space.dart';
import 'package:simple_todo_list/common/widget/todo_icon.dart';
import 'package:simple_todo_list/data/todos/model/todo_data.dart';

/// Widget for todo entry
class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.onTap,
  });

  /// The todo entry to be shown
  final TodoData todo;

  /// Action when entry is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.spaceM),
        child: Row(
          children: [
            TodoIcon(title: todo.title),
            const SizedBox(width: AppSpace.spaceM),
            Expanded(
              child: Text(
                todo.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: todo.isDone ? Colors.grey : Colors.black87,
                      decoration:
                          todo.isDone ? TextDecoration.lineThrough : null,
                      decorationColor:
                          todo.isDone ? Colors.grey : Colors.black87,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
