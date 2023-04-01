import 'package:simple_todo_list/app/registry/di.dart';
import 'package:simple_todo_list/data/database/database.dart';

/// Local Data Source for Todo List
class TodoLocalDataSource {
  final AppDatabase database = inject();

  /// Get todo data
  Future<List<Todo>> getTodos({
    required int limit,
    required int offset,
  }) {
    return (database.select(database.todos)..limit(limit, offset: offset))
        .get();
  }

  /// Create new todo data
  Future<Todo> createTodos(TodosCompanion todo) async {
    return await database.into(database.todos).insertReturning(todo);
  }

  /// Update todo data
  Future<void> updateTodos(int id, TodosCompanion todo) async {
    await (database.update(database.todos)..where((t) => t.id.equals(id)))
        .write(todo);
  }

  /// Update delete specific todo data
  Future<void> deleteTodos(int id) async {
    await (database.delete(database.todos)..where((t) => t.id.equals(id))).go();
  }

  /// Clear all todos
  Future<void> clearTodos() async {
    await (database.delete(database.todos)).go();
  }
}
