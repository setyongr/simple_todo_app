import 'package:flutter/material.dart';
import 'package:simple_todo_list/i18n/strings.g.dart';
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
      title: Text(context.t.add_title),
      content: TextField(
        key: const Key(MainPageKeys.entryTextField),
        controller: _textEditingController,
        decoration: InputDecoration(hintText: context.t.add_text_hint),
      ),
      actions: <Widget>[
        MaterialButton(
          key: const Key(MainPageKeys.addDialogButton),
          color: Colors.green,
          textColor: Colors.white,
          child: Text(context.t.add_button),
          onPressed: () {
            Navigator.pop(context, _textEditingController.text);
          },
        ),
      ],
    );
  }
}
