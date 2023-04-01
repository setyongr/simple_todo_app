import 'package:go_router/go_router.dart';
import 'package:simple_todo_list/pages/main/presentation/main_page.dart';

class TodoRoutes {
  TodoRoutes._();

  static final routes = [
    main,
  ];

  static final main = GoRoute(
    path: '/',
    name: 'Todo Main',
    builder: (context, state) {
      return const MainPage();
    },
  );
}
