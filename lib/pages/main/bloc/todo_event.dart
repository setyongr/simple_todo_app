part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

/// Fetch data from repository
class FetchTodoEvent extends TodoEvent {
  /// The page to fetch
  final int page;

  /// Should loading state shown
  final bool stealth;

  /// Should replace page instead of append
  final bool replace;

  @override
  List<Object?> get props => [page, stealth, replace];

  const FetchTodoEvent({
    required this.page,
    this.stealth = false,
    this.replace = false,
  });
}

/// Create todo entry
class CreateTodoEvent extends TodoEvent {
  /// The data of the entry
  final TodoData todo;

  const CreateTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

/// Set isDone property of todo entry
class SetDoneEvent extends TodoEvent {
  /// The index of the item
  final int index;

  /// The todo entry that want to be updated
  final TodoData todo;

  /// New isDone property
  final bool isDone;

  @override
  List<Object?> get props => [index, todo, isDone];

  const SetDoneEvent({
    required this.index,
    required this.todo,
    required this.isDone,
  });
}
