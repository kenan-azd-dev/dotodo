import 'package:dotodo/blocs/task/task_bloc.dart';
import 'package:dotodo/blocs/task/tasks_filter.dart';
import 'package:dotodo/features/tasks_overview/view/tasks_overview_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksOverviewPage extends StatelessWidget {
  const TasksOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TasksOverviewBloc>().add(
          TasksOverviewFilterChanged(TasksViewFilter.all),
        );
    return TasksOverviewView();
  }
}
