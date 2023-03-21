import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/models.dart';
import '../../add_task/add_task.dart';
import '../../tasks_overview/view/tasks_overview_view.dart';

import '../../../blocs/category/category_bloc.dart';
import '../../../blocs/category/category_state.dart';
import '../../../blocs/task/task_bloc.dart';

import '../../../utils/constants.dart';

import '../../widgets/tasks_list_view.dart';
import '../../widgets/navigational_tile.dart';
import '../../widgets/empty_tasks_indicator.dart';
import '../../widgets/error_indicator.dart';
import './widgets/tasks_calendar_button.dart';
import './widgets/all_tasks_button.dart';
import './widgets/app_drawer.dart';
import './widgets/app_bar_extension.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddTaskPage(),
          ),
        ),
        child: Icon(Icons.add_rounded),
      ),
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        elevation: 0.0,
        actions: [
          // Navigates to the Tasks' calendar screen.
          TasksCalendarButton(),
          // Navigates to the Tasks screen.
          AllTasksButton(),
        ],
      ),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<CategoriesOverviewBloc, CategoryOverviewState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == CategoryOverviewStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('There was an error loading categories.'),
                      ),
                    );
                }
              },
            ),
            BlocListener<TasksOverviewBloc, TaskOverviewState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == TaskOverviewStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('There was an error loading tasks.'),
                      ),
                    );
                }
              },
            )
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarExtension(),
              Container(
                margin: EdgeInsets.all(kScreenMargin),
                child: NavigationalTile(
                  title: 'Your Ongoing Tasks',
                  isScaffoldBackground: true,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return TasksOverviewView();
                      },
                    ),
                  ),
                ),
              ),
              BlocBuilder<TasksOverviewBloc, TaskOverviewState>(
                builder: (context, state) {
                  if (state.tasks.isEmpty) {
                    if (state.status == TaskOverviewStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.status == TaskOverviewStatus.success) {
                      return Center(
                        child: const EmptyTasksIndicator(),
                      );
                    } else {
                      return Center(
                        heightFactor: 2,
                        child: const ErrorIndicator(),
                      );
                    }
                  }
                  List<Task> ongoingTasks = [];
                  for (var task in state.ongoingTasks) {
                    ongoingTasks.add(task);
                  }
                  return TasksList(items: ongoingTasks);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

