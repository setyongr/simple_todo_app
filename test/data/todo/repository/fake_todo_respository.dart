import 'dart:math';

import 'package:simple_todo_list/data/todos/model/todo_data.dart';
import 'package:simple_todo_list/data/todos/repository/todo_repository.dart';

class FakeTodoRepository extends TodoRepository {
  List<TodoData> todos = [];

  @override
  Future<void> createTodo(TodoData todo) async {
    todos.insert(todos.length, todo.copyWith(id: todos.length));
  }

  @override
  Future<void> setDone(TodoData todo, bool isDone) async {
    todos = todos.map((e) {
      if (e.id == todo.id) {
        return e.copyWith(isDone: isDone);
      }

      return e;
    }).toList();
  }

  @override
  Future<List<TodoData>> getTodos({
    required int limit,
    required int offset,
  }) async {
    return todos.sublist(offset, min(todos.length, limit + offset));
  }

  @override
  Future<void> clear() async {
    todos.clear();
  }

  @override
  Future<void> delete(TodoData todo) async {
    todos = todos.where((e) => e.id != todo.id).toList();
  }
}
