import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_list/app/theme/space.dart';
import 'package:simple_todo_list/common/widget/todo_item.dart';
import 'package:simple_todo_list/pages/main/bloc/todo_bloc.dart';
import 'package:simple_todo_list/pages/main/presentation/main_page_keys.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state.loadState == LoadState.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong!')),
            );
        }
      },
      listenWhen: (previous, current) =>
          previous.loadState != current.loadState,
      builder: (context, state) {
        final length = state.todos.length;
        final hasNext = state.nextPageKey() != null;

        // Show loading
        if (state.todos.isEmpty && state.loadState == LoadState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Show empty view
        if (state.todos.isEmpty && state.loadState == LoadState.loaded) {
          return const Padding(
            padding: EdgeInsets.all(AppSpace.spaceM),
            child: Center(
              child: Text('No todo data'),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<TodoBloc>().add(const FetchTodoEvent(page: 0));
          },
          child: ListView.builder(
            itemCount: length + (hasNext ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= length && hasNext) {
                // Fetch Next Page
                if (state.loadState != LoadState.loading) {
                  context
                      .read<TodoBloc>()
                      .add(FetchTodoEvent(page: state.nextPageKey() ?? 0));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final todo = state.todos[index];
              return Dismissible(
                key: Key('${MainPageKeys.todoDismissPrefix}${todo.id}'),
                onDismissed: (direction) {
                  context
                      .read<TodoBloc>()
                      .add(DeleteTodoEvent(index: index, todo: todo));
                },
                // Show a red background as the item is swiped away.
                background: Container(color: Colors.red),
                child: TodoItem(
                  key: Key('${MainPageKeys.todoEntryPrefix}${todo.id}'),
                  todo: todo,
                  onTap: () {
                    context.read<TodoBloc>().add(
                          SetDoneEvent(
                            index: index,
                            todo: todo,
                            isDone: !todo.isDone,
                          ),
                        );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
