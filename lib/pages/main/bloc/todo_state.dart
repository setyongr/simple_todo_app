part of 'todo_bloc.dart';

class TodoState extends Equatable {
  const TodoState({
    this.loadState = LoadState.initial,
    this.todos = const [],
    this.nextPageKey = const Value(null),
  });

  /// List of todo entry data
  final List<TodoData> todos;

  /// Key for the next page
  final Value<int?> nextPageKey;

  /// Loading state of the data
  final LoadState loadState;

  @override
  List<Object?> get props => [todos, nextPageKey, loadState];

  TodoState copyWith({
    List<TodoData>? todos,
    Value<int?>? nextPageKey,
    LoadState? loadState,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      nextPageKey: nextPageKey ?? this.nextPageKey,
      loadState: loadState ?? this.loadState,
    );
  }
}

enum LoadState {
  initial,
  loading,
  loaded,
  error,
}
