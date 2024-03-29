import 'package:drift/drift.dart';
import 'package:simple_todo_list/data/database/database.dart';
import 'package:simple_todo_list/data/todos/datasource/local/todo_local_datasource.dart';
import 'package:simple_todo_list/data/todos/model/todo_data.dart';
import 'package:simple_todo_list/data/todos/repository/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final _todoLocalDataSource = TodoLocalDataSource();

  @override
  Future<TodoData> createTodo(TodoData todo) async {
    final result = await _todoLocalDataSource.createTodos(TodosCompanion(
      title: Value(todo.title),
      isDone: Value(todo.isDone),
    ));

    return TodoData.fromLocalData(result);
  }

  @override
  Future<void> setDone(TodoData todo, bool isDone) async {
    await _todoLocalDataSource.updateTodos(
      todo.id,
      TodosCompanion(
        isDone: Value(isDone),
      ),
    );
  }

  @override
  Future<List<TodoData>> getTodos({
    required int limit,
    required int offset,
  }) async {
    final result = await _todoLocalDataSource.getTodos(
      limit: limit,
      offset: offset,
    );

    return result.map((e) => TodoData.fromLocalData(e)).toList();
  }

  @override
  Future<void> clear() async {
    await _todoLocalDataSource.clearTodos();
  }

  @override
  Future<void> delete(TodoData todo) async {
    await _todoLocalDataSource.deleteTodos(todo.id);
  }
}
