import 'package:dotodo/data/database/database_helper.dart';
import 'package:dotodo/data/model/task.dart';

/// The `TaskRepository` class provides methods for
/// performing CRUD operations on the Task data model.
class TaskRepository {
  final dbHelper = DatabaseHelper();

  /// Initialize the tasks in the database to make them ready for usage.
  Future<void> initTasksData() async{
    await dbHelper.initTasks();
  }

  /// Inserts a new task into the database.
  Future<int> insertTask(Task task) async {
    return dbHelper.saveTask(task);
  }

  /// Returns a list of all tasks in the database.
  Stream<List<Task>> getTasks() {
    return dbHelper.getTasks();
  }

  /// Returns a list of tasks associated with a specific category.
  Future<void> getTasksForCategory(String categoryId) async {
    dbHelper.getTasksForCategory(categoryId);
  }

  /// Updates an existing task in the database.
  Future<int> updateTask(Task task) async {
    return dbHelper.updateTask(task);
  }

  /// Updates an existing task completion status.
  Future<int> updateTaskCompleted({
    required String taskId,
    required bool isCompleted,
  }) async {
    return dbHelper.updateTaskCompleted(
      id: taskId,
      isCompleted: isCompleted,
    );
  }

  /// Deletes a task from the database.
  Future<int> deleteTask(String id) async {
    return dbHelper.deleteTask(id);
  }
}
