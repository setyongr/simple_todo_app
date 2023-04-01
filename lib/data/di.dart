import 'package:simple_todo_list/app/registry/di.dart';
import 'package:simple_todo_list/data/database/database.dart';
import 'package:simple_todo_list/data/todos/repository/todo_repository.dart';
import 'package:simple_todo_list/data/todos/repository/todo_repository_impl.dart';

void setupDataInjection() {
  inject
      .registerLazySingleton<AppDatabase>(() => AppDatabase(nativeDatabase()));
  inject.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl());
}
