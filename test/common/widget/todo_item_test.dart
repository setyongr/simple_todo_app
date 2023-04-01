import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_todo_list/common/widget/todo_item.dart';
import 'package:simple_todo_list/data/todos/model/todo_data.dart';

void main() {
  group('TodoItem test', () {
    testWidgets('TodoItem show correctly', (tester) async {
      // Given
      const data = TodoData(title: 'entry', isDone: false);

      // When
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Material(child: TodoItem(todo: data, onTap: () {})),
        ),
      );

      // Then
      expect(find.text(data.title), findsOneWidget);
    });
  });
}
