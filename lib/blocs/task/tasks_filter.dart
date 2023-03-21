import 'package:dotodo/data/model/models.dart';

enum TasksViewFilter { all, activeOnly, completedOnly }

extension TasksViewFilterX on TasksViewFilter {
  bool apply(Task task) {
    switch (this) {
      case TasksViewFilter.all:
        return true;
      case TasksViewFilter.activeOnly:
        return !task.isCompleted;
      case TasksViewFilter.completedOnly:
        return task.isCompleted;
    }
  }

  Iterable<Task> applyAll(Iterable<Task> tasks) {
    return tasks.where(apply);
  }
}
