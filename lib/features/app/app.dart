import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/category/category_bloc.dart';
import '../../blocs/category/category_event.dart';
import '../../blocs/task/task_bloc.dart';

import '../../data/repositories/category_repository.dart';
import '../../data/repositories/task_repository.dart';

import '../../features/app/view/app_view.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => CategoryRepository()),
        RepositoryProvider(create: (_) => TaskRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CategoriesOverviewBloc(
              categoryRepository: context.read<CategoryRepository>(),
            )..add(const CategoryOverviewSubscriptionRequestedEvent()),
          ),
          BlocProvider(
            create: (context) => TasksOverviewBloc(
              taskRepository: context.read<TaskRepository>(),
            )..add(TaskOverviewSubscriptionRequestedEvent()),
          ),
        ],
        child: AppView(),
      ),
    );
  }
}
