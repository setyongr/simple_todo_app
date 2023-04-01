// A wrapper for a value
import 'package:equatable/equatable.dart';

class Value<T> extends Equatable {
  final T value;

  const Value(this.value);

  T call() {
    return value;
  }

  @override
  List<Object?> get props => [value];
}
