import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_todo_list/data/database/tables/todos.dart';
import 'package:path/path.dart' as p;
part 'database.g.dart';

@DriftDatabase(tables: [
  Todos,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor queryExecutor) : super(queryExecutor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase nativeDatabase() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
