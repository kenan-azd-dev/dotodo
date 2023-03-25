import 'package:dotodo/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Navigates you to `TasksCalendarPage` (not implemented yet)
class TasksCalendarButton extends StatelessWidget {
  const TasksCalendarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: l10n.tasksCalendar,
      onPressed: () {},
      icon: Icon(Icons.calendar_month_rounded),
    );
  }
}