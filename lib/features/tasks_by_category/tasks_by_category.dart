import 'package:dotodo/data/model/category.dart';
import 'package:flutter/material.dart';

import './view/tasks_by_category_view.dart';

class TasksByCategory extends StatelessWidget {
  const TasksByCategory({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return TasksByCategoryView(
      category: category,
    );
  }
}
