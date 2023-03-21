part of 'task_bloc.dart';

abstract class TaskOverviewEvent extends Equatable {
  const TaskOverviewEvent();

  @override
  List<Object> get props => [];
}

class TaskOverviewSubscriptionRequestedEvent extends TaskOverviewEvent {
  const TaskOverviewSubscriptionRequestedEvent();
}

class SaveTaskEvent extends TaskOverviewEvent {
  const SaveTaskEvent({required this.task});

  final Task task;
  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TaskOverviewEvent {
  const UpdateTaskEvent({required this.task});

  final Task task;
  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskOverviewEvent {
  const DeleteTaskEvent({required this.taskId});

  final String taskId;
  @override
  List<Object> get props => [taskId];
}

class CompleteTaskEvent extends TaskOverviewEvent {
  const CompleteTaskEvent({
    required this.taskId,
    required this.isCompleted,
  });

  final String taskId;
  final bool isCompleted;
  @override
  List<Object> get props => [
        taskId,
        isCompleted,
      ];
}

class TasksOverviewFilterChanged extends TaskOverviewEvent {
  const TasksOverviewFilterChanged(this.filter);

  final TasksViewFilter filter;

  @override
  List<Object> get props => [filter];
}
