import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_todo_list/i18n/strings.g.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: MaterialApp.router(
        title: 'Todo App',
        themeMode: ThemeMode.light,
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => child,
            ),
          ],
        ),
      ),
    );
  }
}
