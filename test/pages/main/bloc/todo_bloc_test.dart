import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_todo_list/data/todos/model/todo_data.dart';
import 'package:simple_todo_list/pages/main/bloc/todo_bloc.dart';

import '../../../data/todo/repository/fake_todo_respository.dart';

void main() {
  group('FetchTodoEvent test', () {
    final fakeRepo = FakeTodoRepository();
    final todos = [
      const TodoData(id: 0, title: 'entry', isDone: false),
    ];

    blocTest(
      'When [FetchTodoEvent] added return correct state',
      build: () => TodoBloc(todoRepository: fakeRepo),
      setUp: () {
        fakeRepo.todos.addAll(todos);
      },
      act: (bloc) => bloc.add(const FetchTodoEvent(page: 0)),
      expect: () => [
        const TodoState(
          loadState: LoadState.loading,
        ),
        TodoState(
          loadState: LoadState.loaded,
          todos: todos,
        ),
      ],
    );
  });

  group('CreateTodoEvent test', () {
    final fakeRepo = FakeTodoRepository();
    const data = TodoData(title: 'entry');

    blocTest(
      'When [CreateTodoEvent] added return correct state',
      build: () => TodoBloc(todoRepository: fakeRepo),
      act: (bloc) => bloc.add(const CreateTodoEvent(data)),
      expect: () => [
        const TodoState(
          loadState: LoadState.loaded,
        ),
        const TodoState(
          loadState: LoadState.loading,
        ),
        TodoState(
          loadState: LoadState.loaded,
          todos: [
            data.copyWith(id: 0),
          ],
        ),
      ],
    );
  });
}
