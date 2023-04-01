import 'package:go_router/go_router.dart';
import 'package:simple_todo_list/app/routes/todo_routes.dart';

final routesRegistry = <GoRoute>[
  ...TodoRoutes.routes,
];
