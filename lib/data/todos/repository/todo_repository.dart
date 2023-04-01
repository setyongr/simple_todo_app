import 'package:simple_todo_list/data/todos/model/todo_data.dart';

abstract class TodoRepository {
  /// Get list of todos
  Future<List<TodoData>> getTodos({
    required int limit,
    required int offset,
  });

  /// Create a new todo entry
  Future<void> createTodo(TodoData todo);

  /// Set isDone for specific todo entry
  Future<void> setDone(TodoData todo, bool isDone);

  /// Delete for specific todo entry
  Future<void> delete(TodoData todo);

  /// Clear all todo entry
  Future<void> clear();
}
