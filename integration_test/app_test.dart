import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simple_todo_list/app/registry/di.dart';
import 'package:simple_todo_list/data/database/database.dart';
import 'package:simple_todo_list/i18n/strings.g.dart';

import 'package:simple_todo_list/main.dart' as app;
import 'package:simple_todo_list/pages/main/presentation/main_page_keys.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('add todo entry', (tester) async {
      await app.main(additionalSetup: () async {
        inject.allowReassignment = true;
        inject.registerSingleton<AppDatabase>(
          AppDatabase(NativeDatabase.memory()),
        );
      });
      await tester.pumpAndSettle();

      // When
      await tester.tap(find.byKey(const Key(MainPageKeys.addFAB)));
      await tester.pumpAndSettle();

      // Then
      expect(find.text(t.add_text_hint), findsOneWidget);

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
