import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_todo_list/common/value.dart';
import 'package:simple_todo_list/data/todos/model/todo_data.dart';
import 'package:simple_todo_list/data/todos/repository/todo_repository.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  static const fetchLimit = 5;

  final TodoRepository todoRepository;

  TodoBloc({
    required this.todoRepository,
  }) : super(const TodoState()) {
    on<FetchTodoEvent>(_onFetchTodoEvent);
    on<CreateTodoEvent>(_onCreateTodoEvent);
    on<SetDoneEvent>(_onSetDoneEvent);
  }

  Future<void> _onFetchTodoEvent(
    FetchTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(
      loadState: LoadState.loading,
      todos: event.page == 0 && !event.stealth ? [] : null,
    ));

    var todos = <TodoData>[];

    if (state.loadState == LoadState.error) {
      emit(state.copyWith(loadState: LoadState.loaded));
    }

    try {
      todos = await todoRepository.getTodos(
        limit: fetchLimit,
        offset: event.page * fetchLimit,
      );
    } catch (e) {
      return emit(state.copyWith(loadState: LoadState.error));
    }

    var newTodos = state.todos + todos;
    var nextPageKey = todos.length < fetchLimit ? null : event.page + 1;

    // Replace data on page instead of appending
    if (event.replace && state.todos.isNotEmpty) {
      final start = event.page * fetchLimit;
      final end = start + fetchLimit;

      final startPart = state.todos.sublist(0, start);
      final endPart =
          end < state.todos.length ? state.todos.sublist(end) : <TodoData>[];

      // Update todos data
      newTodos = startPart + todos + endPart;

      // Don't update next page key
      nextPageKey = null;
    }

    emit(
      state.copyWith(
        loadState: LoadState.loaded,
        todos: newTodos,
        nextPageKey: Value(nextPageKey),
      ),
    );
  }

  Future<void> _onCreateTodoEvent(
    CreateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      emit(state.copyWith(loadState: LoadState.loaded));
      await todoRepository.createTodo(
        event.todo,
      );
    } catch (e) {
      return emit(state.copyWith(loadState: LoadState.error));
    }

    // Update data
    add(
      FetchTodoEvent(
        page: (state.todos.length / fetchLimit).floor(),
        replace: true,
        stealth: true,
      ),
    );
  }

  Future<void> _onSetDoneEvent(
    SetDoneEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      emit(state.copyWith(loadState: LoadState.loaded));
      await todoRepository.setDone(
        event.todo,
        event.isDone,
      );
    } catch (e) {
      return emit(state.copyWith(loadState: LoadState.error));
    }

    // Update Related Page
    add(
      FetchTodoEvent(
        page: (event.index / fetchLimit).floor(),
        replace: true,
        stealth: true,
      ),
    );
  }
}
