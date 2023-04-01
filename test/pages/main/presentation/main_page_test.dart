import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_todo_list/app/registry/di.dart';
import 'package:simple_todo_list/data/todos/repository/todo_repository.dart';
import 'package:simple_todo_list/pages/main/presentation/main_page.dart';
import 'package:simple_todo_list/pages/main/presentation/main_page_keys.dart';

import '../../../data/todo/repository/fake_todo_respository.dart';
import '../../../test_suites/test_di.dart';
import '../../../test_suites/test_page.dart';

void main() {
  setUp(() {
    setupTestInjection();

    inject.registerSingleton<TodoRepository>(FakeTodoRepository());
  });

  group('Main Page Test', () {
    testWidgets('Show empty view', (tester) async {
      // Given & When
      await tester.pumpWidget(
        const TestPage(child: MainPage()),
      );
      await tester.pumpAndSettle();

      // Then
      expect(find.text('No todo data'), findsOneWidget);
    });

    testWidgets('Add todo correctly', (tester) async {
      // Given
      await tester.pumpWidget(
        const TestPage(child: MainPage()),
      );
      await tester.pumpAndSettle();

      // When
      await tester.tap(find.byKey(const Key(MainPageKeys.addFAB)));
      await tester.pumpAndSettle();

      // Then
      expect(find.text('Add a new todo item'), findsOneWidget);

      // When
      await tester.enterText(
          find.byKey(const Key(MainPageKeys.entryTextField)), 'entry');
      await tester.tap(find.byKey(const Key(MainPageKeys.addDialogButton)));
      await tester.pumpAndSettle();

      // Then
      expect(find.text('entry'), findsOneWidget);
    });
  });
}
