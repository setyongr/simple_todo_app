import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_todo_list/app/registry/routes_registry.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    const FlexScheme usedScheme = FlexScheme.brandBlue;
    return MaterialApp.router(
      title: 'Todo App',
      theme: FlexThemeData.light(
        scheme: usedScheme,
        appBarElevation: 0.5,
        useMaterial3: true,
        subThemesData: const FlexSubThemesData(),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: usedScheme,
        appBarElevation: 2,
        useMaterial3: true,
        subThemesData: const FlexSubThemesData(),
      ),
      themeMode: ThemeMode.light,
      routerConfig: GoRouter(
        routes: routesRegistry,
      ),
    );
  }
}
