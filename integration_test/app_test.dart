import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:simple_todo_list/main.dart' as app;
import 'package:simple_todo_list/pages/main/presentation/main_page_keys.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('add todo entry', (tester) async {
      await app.main();
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
