import 'package:bloc/bloc.dart';
import 'package:dotodo/blocs/task/tasks_filter.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/task.dart';
import '../../data/repositories/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TasksOverviewBloc extends Bloc<TaskOverviewEvent, TaskOverviewState> {
  TasksOverviewBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const TaskOverviewState()) {
    on<TaskOverviewSubscriptionRequestedEvent>(_onSubscriptionRequested);
    on<SaveTaskEvent>(_onSaveTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<CompleteTaskEvent>(_onCompleteTask);
    on<TasksOverviewFilterChanged>(_onFilterChanged);
  }
  final TaskRepository _taskRepository;

  Future<void> _onSubscriptionRequested(
    TaskOverviewSubscriptionRequestedEvent event,
    Emitter<TaskOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => TaskOverviewStatus.loading));
    await emit.forEach<List<Task>>(
      _taskRepository.getTasks(),
      onData: (tasks) => state.copyWith(
        status: () => TaskOverviewStatus.success,
        tasks: () => tasks,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TaskOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onSaveTask(
    SaveTaskEvent event,
    Emitter<TaskOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => TaskOverviewStatus.loading));
    await _taskRepository.insertTask(event.task);
  }

  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<TaskOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => TaskOverviewStatus.loading));
    await _taskRepository.updateTask(event.task);
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => TaskOverviewStatus.loading));
    await _taskRepository.deleteTask(event.taskId);
  }

  Future<void> _onCompleteTask(
    CompleteTaskEvent event,
    Emitter<TaskOverviewState> emit,
  ) async {
    print(event.isCompleted);
    emit(state.copyWith(
      status: () => TaskOverviewStatus.loading,
    ));
    await _taskRepository.updateTaskCompleted(
        taskId: event.taskId, isCompleted: !event.isCompleted);
  }

  void _onFilterChanged(
    TasksOverviewFilterChanged event,
    Emitter<TaskOverviewState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }
}
