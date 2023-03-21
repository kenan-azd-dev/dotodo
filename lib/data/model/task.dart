import 'package:dotodo/data/model/category.dart';
import 'package:equatable/equatable.dart';

/// A single `Task` item.
///
/// Every `task` requires:
/// 1. [id] (`String`) required!
/// 2. [title] (`String`) required!
/// 3. [description] (`String`) optional defaults to empty string
/// 4. [dateTime] (`DateTime?`) optional
/// 5. [timeOfDay] (`DateTime?`) optional
/// 6. [isCompleted] (`bool`) optional defaults to false
/// 7. [categoryId] (`int`) required!
///
/// [Task]s are immutable and can be copied using [copyWith].
/// Also they could be converted from and to `Map` using
/// [Task.fromMap] and [toMap] respectively.
class Task extends Equatable {
  const Task({
    required this.id,
    required this.title,
    required this.categoryId,
    this.dateTime,
    this.timeOfDay,
    this.description = '',
    this.isCompleted = false,
  });

  /// Converts from `map` to `Task`
  // Using constructor instead of static function because it's better practice.
  Task.fromMap(Map<String, dynamic> map, Category category)
      : id = map['id'] as String,
        title = map['title'] as String,
        description = map['description'] as String,
        dateTime = map['dateTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
        timeOfDay = map['timeOfDay'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['timeOfDay'] as int),
        isCompleted = map['isCompleted'] == 1,
        categoryId = category.id;

  /// The unique identifier of the `task`.
  ///
  /// Cannot be empty.
  final String id;

  /// The title of the `task`.
  ///
  /// Cannot be empty.
  final String title;

  /// The description of the `task`.
  ///
  /// Defaults to empty `String`.
  final String description;

  /// The date of this `task`.
  ///
  /// Could be null.
  final DateTime? dateTime;

  /// The time of this `task`.
  ///
  /// Could be null.
  final DateTime? timeOfDay;

  /// Whether the `task` is completed or not.
  ///
  /// Defaults to `false`
  final bool isCompleted;

  /// The id of the category to which this `task` is assigned.
  ///
  /// Cannot be empty, because every `task` has a `category`.
  final String categoryId;

  /// Returns a copy of this `task` with the given values updated.
  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dateTime,
    DateTime? timeOfDay,
    bool? isCompleted,
    int? categoryId,
  }) {
    return Task(
      id: this.id,
      title: title ?? this.title,
      description: description ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      isCompleted: isCompleted ?? this.isCompleted,
      categoryId: this.categoryId,
    );
  }

  /// Converts from `Task` to `map`
  // Note that the isCompleted property of the Task model is stored as an
  // integer in the database, where 1 represents true and 0 represents false.
  // This is because SQLite does not have a boolean data type.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime == null ? null : dateTime!.millisecondsSinceEpoch,
      'timeOfDay': timeOfDay == null ? null : timeOfDay!.millisecondsSinceEpoch,
      'isCompleted': isCompleted ? 1 : 0,
      'categoryId': categoryId
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dateTime,
        timeOfDay,
        isCompleted,
        categoryId,
      ];
}
