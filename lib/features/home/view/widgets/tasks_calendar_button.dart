import 'package:flutter/material.dart';

/// Navigates you to `TasksCalendarPage` (not implemented yet)
class TasksCalendarButton extends StatelessWidget {
  const TasksCalendarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Tasks calendar',
      onPressed: () {},
      icon: Icon(Icons.calendar_month_rounded),
    );
  }
}