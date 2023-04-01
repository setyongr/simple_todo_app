import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_list/app/registry/di.dart';
import 'package:simple_todo_list/data/todos/model/todo_data.dart';
import 'package:simple_todo_list/i18n/strings.g.dart';
import 'package:simple_todo_list/pages/main/bloc/todo_bloc.dart';
import 'package:simple_todo_list/pages/main/presentation/main_page_keys.dart';
import 'package:simple_todo_list/pages/main/presentation/widget/create_todo_dialog.dart';
import 'package:simple_todo_list/pages/main/presentation/widget/todo_list_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(
        todoRepository: inject(),
      )..add(const FetchTodoEvent(page: 0)),
      child: const MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.title),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TodoBloc>().add(const ClearTodoEvent());
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key(MainPageKeys.addFAB),
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (context) => const CreateTodoDialog(),
          ).then((value) {
            if (value != null) {
              context
                  .read<TodoBloc>()
                  .add(CreateTodoEvent(TodoData(title: value)));
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: const SafeArea(
        child: TodoListView(),
      ),
    );
  }
}
