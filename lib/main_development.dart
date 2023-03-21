import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './bootstrap.dart';

import 'data/database/database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbInstance = DatabaseHelper();

  await dbInstance.initCategories();
  await dbInstance.initTasks();

  final prefs = await SharedPreferences.getInstance();

  await bootstrap(prefs);
}
