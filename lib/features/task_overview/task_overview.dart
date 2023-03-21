import 'package:dotodo/blocs/task/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './view/task_overview_view.dart';
import '../../data/model/models.dart';

class TaskOverviewPage extends StatelessWidget {
  const TaskOverviewPage({
    super.key,
    required Task task,
  }) : _task = task;

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksOverviewBloc, TaskOverviewState>(
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        final task = state.tasks.firstWhere((element) => element.id == _task.id);
        return TaskOverviewView(task: task);
      },
    );
  }
}
