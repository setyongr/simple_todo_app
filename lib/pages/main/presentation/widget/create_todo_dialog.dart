import 'package:flutter/material.dart';
import 'package:simple_todo_list/pages/main/presentation/main_page_keys.dart';

class CreateTodoDialog extends StatefulWidget {
  const CreateTodoDialog({super.key});

  @override
  State<CreateTodoDialog> createState() => _CreateTodoDialogState();
}

class _CreateTodoDialogState extends State<CreateTodoDialog> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new todo item'),
      content: TextField(
        key: const Key(MainPageKeys.entryTextField),
        controller: _textEditingController,
        decoration: const InputDecoration(hintText: "Type your new todo"),
      ),
      actions: <Widget>[
        MaterialButton(
          key: const Key(MainPageKeys.addDialogButton),
          color: Colors.green,
          textColor: Colors.white,
          child: const Text('Add'),
          onPressed: () {
            Navigator.pop(context, _textEditingController.text);
          },
        ),
      ],
    );
  }
}
