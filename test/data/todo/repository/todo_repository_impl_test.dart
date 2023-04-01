import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_todo_list/app/registry/di.dart';
import 'package:simple_todo_list/data/database/database.dart';
import 'package:simple_todo_list/data/todos/model/todo_data.dart';
import 'package:simple_todo_list/data/todos/repository/todo_repository.dart';
import 'package:simple_todo_list/data/todos/repository/todo_repository_impl.dart';

import '../../../test_suites/test_di.dart';

void main() {
  late AppDatabase database;
  late TodoRepository todoRepository;
  setUp(() {
    setupTestInjection();

    database = AppDatabase(NativeDatabase.memory());
    inject.registerSingleton<AppDatabase>(database);

    todoRepository = TodoRepositoryImpl();
  });

  tearDown(() {
    database.close();
  });

  group('getTodos test', () {
    test('getTodos should return todos entry', () async {
      // Given
      int limit = 5;
      int offset = 0;
      List<TodoData> expectedResult = [
        const TodoData(id: 1, title: 'entry', isDone: false),
      ];

      await database.into(database.todos).insert(
          const TodosCompanion(title: Value('entry'), isDone: Value(false)));

      // When
      final todos = await todoRepository.getTodos(limit: limit, offset: offset);

      // Then
      expect(todos, expectedResult);
    });
  });

  group('createTodo test', () {
    test('createTodo should successfully create todo', () async {
      // Given
      const data = TodoData(title: 'entry', isDone: false);

      // When
      await todoRepository.createTodo(data);

      // Then
      final result =
          await database.select(database.todos).map((d) => d.title).get();
      expect(result, ['entry']);
    });
  });

  group('setDone test', () {
    test('setDone should successfully update todo', () async {
      // Given
      const data = TodoData(id: 1, title: 'entry', isDone: false);
      await database.into(database.todos).insert(
          const TodosCompanion(title: Value('entry'), isDone: Value(false)));

      // When
      await todoRepository.setDone(data, true);

      // Then
      final result = await (database.select(database.todos)
            ..where((e) => e.id.equals(data.id)))
          .getSingle();
      expect(result.isDone, true);
    });
  });
}
