import 'dart:async';

// models
import 'package:dotodo/data/model/category.dart';
import 'package:dotodo/data/model/task.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:sqflite/sqflite.dart';

/// The `DatabaseHelper` class is responsible for creating the SQLite database
/// and managing the CRUD (Create, Read, Update, Delete) operations
/// on the Category and Task data models.
class DatabaseHelper {
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  final _categoriesStreamContoller =
      BehaviorSubject<List<Category>>.seeded(const []);
  final _tasksStreamContoller = BehaviorSubject<List<Task>>.seeded(const []);

  static Database? _db;

  Future<Database> get db async {
    // if the database is created (which means it's not null),
    // then return it
    if (_db != null) {
      return _db!;
    }
    // else, call initDb
    return _db = await initDb();
  }

  Future<Database> initDb() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'dotodo.db');
    final theDb = await openDatabase(path, version: 2, onCreate: _onCreate);
    return theDb;
  }

  Future<void> _onCreate(Database db, int version) async {
    // creates the category table
    await db.execute('CREATE TABLE Category(id TEXT PRIMARY KEY, name TEXT)');
    // create the tasks table
    await db.execute(
      '''
        CREATE TABLE Task(
          id TEXT PRIMARY KEY,
          title TEXT,
          description TEXT,
          dateTime INTEGER,
          timeOfDay INTEGER,
          isCompleted INTEGER,
          categoryId INTEGER,
          FOREIGN KEY(categoryId) REFERENCES Category(id)
        )
        ''',
    );
  }

  // ========== Categories Related Methods ========== //

  Future<void> initCategories() async {
    final listOfCategories = await _getCategoriesFromDB();
    if (listOfCategories.isNotEmpty) {
      _categoriesStreamContoller.add(listOfCategories);
    } else {
      _categoriesStreamContoller.add(const []);
    }
  }

  Stream<List<Category>> getCategories() =>
      _categoriesStreamContoller.asBroadcastStream();

  /// saves a single [category] to database.
  Future<void> saveCategory(Category category) async {
    final newCategories = [..._categoriesStreamContoller.value];
    final categoryIndex = newCategories.indexWhere((t) => t.id == category.id);
    final dbClient = await db;
    if (categoryIndex >= 0) {
      newCategories[categoryIndex] = category;
      await dbClient.rawUpdate('UPDATE Category SET name = ? WHERE id = ?',
          [category.name, category.id]);
      _categoriesStreamContoller.add(newCategories);
      return;
    } else {
      newCategories.add(category);
    }
    _categoriesStreamContoller.add(newCategories);
    await dbClient.rawInsert('INSERT INTO Category (id, name) VALUES (?, ?)',
        [category.id, category.name]);
  }

  /// returns a single category from database.
  /// requires the category [id].
  Future<Category> getCategory(String id) async {
    final dbClient = await db;
    final list =
        await dbClient.rawQuery('SELECT * FROM Category WHERE id = ?', [id]);
    return Category.fromMap(list.first);
  }

  /// returns a list of categories from database.
  Future<List<Category>> _getCategoriesFromDB() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('SELECT * FROM Category');
    final categories = <Category>[];
    for (var i = 0; i < list.length; i++) {
      final category = Category.fromMap(list[i]);
      categories.add(category);
    }
    return categories;
  }

  /// deletes a category and the tasks which this category has from database.
  /// requires the category [id]
  Future<int> deleteCategory(Category category) async {
    final newCategories = [..._categoriesStreamContoller.value];
    final categoryIndex = newCategories.indexWhere((t) => t.id == category.id);
    if (categoryIndex >= 0) {
      newCategories.removeAt(categoryIndex);
    }
    _categoriesStreamContoller.add(newCategories);
    final newTasks = [..._tasksStreamContoller.value];
    newTasks.removeWhere((element) => element.categoryId == category.id);
    _tasksStreamContoller.add(newTasks);
    final dbClient = await db;
    await dbClient
        .rawDelete('DELETE FROM Category WHERE id = ?', [category.id]);
    await dbClient
        .rawDelete('DELETE FROM Task WHERE categoryId = ?', [category.id]);
    return 1;
  }

  // ========== Tasks Related Methods ========== //

  Future<void> initTasks() async {
    final listOfTasks = await _getTasksFromDB();
    if (listOfTasks.isNotEmpty) {
      _tasksStreamContoller.add(listOfTasks);
    } else {
      _tasksStreamContoller.add(const []);
    }
  }

  Stream<List<Task>> getTasks() => _tasksStreamContoller.asBroadcastStream();

  /// saves a single [task] to database.
  Future<int> saveTask(Task task) async {
    final newTasks = [..._tasksStreamContoller.value];
    final taskIndex = newTasks.indexWhere((t) => t.id == task.id);
    if (taskIndex >= 0) {
      newTasks[taskIndex] = task;
    } else {
      newTasks.add(task);
    }
    _tasksStreamContoller.add(newTasks);
    final dbClient = await db;
    final res = await dbClient.insert('Task', task.toMap());
    return res;
  }

  /// returns a list of tasks from database.
  Future<List<Task>> _getTasksFromDB() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('SELECT * FROM Task');
    final tasks = <Task>[];
    for (var i = 0; i < list.length; i++) {
      final map = list[i];
      final categoryId = map['categoryId']! as String;
      final category = await getCategory(categoryId);
      final task = Task.fromMap(map, category);
      tasks.add(task);
    }
    return tasks;
  }

  /// returns a list of tasks from database.
  Future<void> getTasksForCategory(String categoryId) async {
    final dbClient = await db;
    final list = await dbClient.rawQuery(
      'SELECT * FROM Task WHERE categoryId = ?',
      [categoryId],
    );
    final tasks = <Task>[];
    for (var i = 0; i < list.length; i++) {
      final map = list[i];
      final categoryId = map['categoryId']! as String;
      final category = await getCategory(categoryId);
      final task = Task.fromMap(map, category);
      tasks.add(task);
    }
    if (tasks.isNotEmpty) {
      _tasksStreamContoller.add(tasks);
    } else {
      _tasksStreamContoller.add(const []);
    }
  }

  /// updates the task completion status in the database.
  /// requires the task [id] and the [isCompleted] boolean.
  Future<int> updateTaskCompleted({
    required String id,
    required bool isCompleted,
  }) async {
    final newTasks = [..._tasksStreamContoller.value];
    final taskIndex = newTasks.indexWhere((t) => t.id == id);
    newTasks[taskIndex] =
        newTasks[taskIndex].copyWith(isCompleted: isCompleted);
    _tasksStreamContoller.add(newTasks);
    final dbClient = await db;
    final res = await dbClient.rawUpdate(
      'UPDATE Task SET isCompleted = ? WHERE id = ?',
      [if (isCompleted) 1 else 0, id],
    );
    return res;
  }

  /// updates the task
  Future<int> updateTask(Task task) async {
    final dbClient = await db;
    final taskMap = task.toMap();
    final newTasks = [..._tasksStreamContoller.value];
    final taskIndex = newTasks.indexWhere((t) => t.id == task.id);
    if (taskIndex >= 0) {
      newTasks[taskIndex] = task;
    } else {
      newTasks.add(task);
    }
    _tasksStreamContoller.add(newTasks);
    final res = await dbClient.rawUpdate(
      '''
      UPDATE Task SET
                  title = ?,
                  description = ?,
                  dateTime = ?,
                  timeOfDay = ?
                  WHERE id = ?
      ''',
      [
        taskMap['title'],
        taskMap['description'],
        taskMap['dateTime'],
        taskMap['timeOfDay'],
        task.id,
      ],
    );
    return res;
  }

  Future<int> deleteTask(String id) async {
    final newTasks = [..._tasksStreamContoller.value];
    final taskIndex = newTasks.indexWhere((t) => t.id == id);
    if (taskIndex >= 0) {
      newTasks.removeAt(taskIndex);
    }
    _tasksStreamContoller.add(newTasks);
    final dbClient = await db;
    final res = await dbClient.rawDelete('DELETE FROM Task WHERE id = ?', [id]);
    return res;
  }
}
