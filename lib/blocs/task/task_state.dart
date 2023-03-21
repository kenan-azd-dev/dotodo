part of 'task_bloc.dart';

enum TaskOverviewStatus { initial, loading, success, failure }

class TaskOverviewState extends Equatable {
  const TaskOverviewState({
    this.status = TaskOverviewStatus.initial,
    this.tasks = const [],
    this.filter = TasksViewFilter.all,
  });

  final TaskOverviewStatus status;
  final List<Task> tasks;
  final TasksViewFilter filter;

  Iterable<Task> get filteredTasks => filter.applyAll(tasks);

  Iterable<Task> get ongoingTasks => tasks.where((element) => element.isCompleted == false);
  @override
  List<Object> get props => [
        status,
        tasks,
        filter,
      ];

  TaskOverviewState copyWith({
    TaskOverviewStatus Function()? status,
    List<Task> Function()? tasks,
    TasksViewFilter Function()? filter,
  }) {
    return TaskOverviewState(
      status: status != null ? status() : this.status,
      tasks: tasks != null ? tasks() : this.tasks,
      filter: filter != null ? filter() : this.filter,
    );
  }
}



/* 
part of 'category_bloc.dart';

enum CategoryOverviewStatus { initial, loading, success, failure }

class CategoryOverviewState extends Equatable {
  const CategoryOverviewState({
    this.status = CategoryOverviewStatus.initial,
    this.categories = const [],
  });

  final CategoryOverviewStatus status;
  final List<Category> categories;

  @override
  List<Object?> get props => [
        status,
        categories,
      ];

  CategoryOverviewState copyWith({
    CategoryOverviewStatus Function()? status,
    List<Category> Function()? categories,
  }) {
    return CategoryOverviewState(
      status: status != null ? status() : this.status,
      categories: categories != null ? categories() : this.categories,
    );
  }
}

 */