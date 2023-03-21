import 'package:dotodo/data/model/models.dart';
import 'package:flutter/material.dart';
import './view/add_task_view.dart';

/// We need the Category and Task and isEdit arguments
/// in case we are editing the task.
/// we need the Category argument in case we are adding the task from
/// the category screen (TasksByCategoryPage).
class AddTaskPage extends StatelessWidget {
  const AddTaskPage({
    super.key,
    Category? category,
    Task? task,
    bool isEdit = false,
  })  : _category = category,
        _isEdit = isEdit,
        _task = task;

  final Category? _category;
  final bool _isEdit;
  final Task? _task;

  @override
  Widget build(BuildContext context) {
    return AddTaskView(
      category: _category,
      isEdit: _isEdit,
      task: _task,
    );
  }
}
