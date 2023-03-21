import 'package:dotodo/blocs/task/task_bloc.dart';
import 'package:dotodo/blocs/task/tasks_filter.dart';
import 'package:dotodo/utils/constants.dart';
import 'package:dotodo/data/model/models.dart';
import 'package:dotodo/features/widgets/tasks_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksOverviewView extends StatelessWidget {
  const TasksOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tasks'),
        actions: [TasksFilterButton()],
      ),
      body: Column(
        children: [
          BlocBuilder<TasksOverviewBloc, TaskOverviewState>(
            buildWhen: (previous, current) {
              return previous != current;
            },
            builder: (context, state) {
              List<Task> tasks = [];
              for (var task in state.filteredTasks) {
                tasks.add(task);
              }
              return TasksList(items: tasks);
            },
          ),
        ],
      ),
    );
  }
}

class TasksFilterButton extends StatelessWidget {
  const TasksFilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kSmallBorderRadius),
      ),
      onSelected: (filter) {
        context
            .read<TasksOverviewBloc>()
            .add(TasksOverviewFilterChanged(filter));
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text('All Tasks'),
            value: TasksViewFilter.all,
          ),
          PopupMenuItem(
            child: Text('Completed Only'),
            value: TasksViewFilter.completedOnly,
          ),
          PopupMenuItem(
            child: Text('Ongoing Only'),
            value: TasksViewFilter.activeOnly,
          ),
        ];
      },
    );
  }
}
