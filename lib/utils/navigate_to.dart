import 'package:dotodo/features/add_category/add_category.dart';
import 'package:dotodo/features/categories_overview/categories_overview.dart';
import 'package:dotodo/features/settings/settings.dart';
import 'package:flutter/material.dart';

class NavigateTo {
  static String addCategoryPage = '/add-category';

  static String categoriesPage = '/categories';

  static String tasksByCategoryPage = '/tasks-category';

  static String settingsPage = '/settings';

  static Map<String, Widget Function(BuildContext)> routes = {
    addCategoryPage: (_) => AddCategoryPage(),
    categoriesPage: (_) => CategoriesOverviewPage(),
    settingsPage: (_) => SettingsPage(),
  };
}
