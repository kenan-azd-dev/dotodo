import 'package:dotodo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import '../../../tasks_overview/tasks_overview_page.dart';

/// Navigates you to `TasksOverviewPage` (All tasks screen).
class AllTasksButton extends StatelessWidget {
  const AllTasksButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: l10n.allTasks,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return TasksOverviewPage();
            },
          ),
        );
      },
      icon: Icon(Icons.task_alt_rounded),
    );
  }
}
