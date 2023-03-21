import 'package:dotodo/blocs/task/task_bloc.dart';
import 'package:dotodo/data/model/category.dart';
import 'package:dotodo/features/add_task/add_task.dart';
import 'package:dotodo/features/widgets/empty_tasks_indicator.dart';
import 'package:dotodo/features/widgets/tasks_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksByCategoryView extends StatelessWidget {
  const TasksByCategoryView({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add task to this category',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTaskPage(category: category),
            ),
          );
        },
        child: Icon(Icons.add_rounded),
      ),
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<TasksOverviewBloc, TaskOverviewState>(
            builder: (context, state) {
              final items = state.tasks
                  .where((element) => element.categoryId == category.id)
                  .toList();
              if (items.isEmpty) {
                return Center(
                  child: EmptyTasksIndicator(),
                );
              }
              return TasksList(
                items: items,
              );
            },
          ),
        ],
      ),
    );
  }
}
