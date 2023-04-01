import 'package:get_it/get_it.dart';
import 'package:simple_todo_list/data/di.dart';

final inject = GetIt.instance;

void setupInjection() {
  setupDataInjection();
}
