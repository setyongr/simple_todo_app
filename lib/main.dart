import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_list/app/app.dart';
import 'package:simple_todo_list/app/registry/di.dart';

Future main({
  Future<void> Function()? additionalSetup,
}) async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    setupInjection();

    await additionalSetup?.call();

    runApp(const App());
  }, (error, stack) {
    // Example error handling
    if (kDebugMode) {
      print(error);
    }
  });
}
