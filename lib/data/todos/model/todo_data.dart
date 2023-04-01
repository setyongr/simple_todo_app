import 'package:equatable/equatable.dart';
import 'package:simple_todo_list/data/database/database.dart';

class TodoData extends Equatable {
  final int id;
  final bool isDone;
  final String title;

  @override
  List<Object?> get props => [id, title, isDone];

  const TodoData({
    this.id = -1,
    this.isDone = false,
    required this.title,
  });

  TodoData copyWith({
    int? id,
    bool? isDone,
    String? title,
  }) {
    return TodoData(
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      title: title ?? this.title,
    );
  }

  static TodoData fromLocalData(Todo todo) {
    return TodoData(
      id: todo.id,
      title: todo.title,
      isDone: todo.isDone,
    );
  }
}
