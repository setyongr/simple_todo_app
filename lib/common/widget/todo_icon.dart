import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_list/app/theme/space.dart';
import 'package:simple_todo_list/common/utils/text_utils.dart';

/// Icon for todo entry item
class TodoIcon extends StatelessWidget {
  const TodoIcon({super.key, required this.title});

  /// The title of the todo entry
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      width: AppSpace.spaceXXL,
      height: AppSpace.spaceXXL,
      child: Center(
        child: Text(
          title.getInitials(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
