import 'package:dotodo/data/database/database_helper.dart';
import 'package:dotodo/data/model/category.dart';

/// The `CategoryRepository` class provides methods for
/// performing CRUD operations
/// on the Category data model.
class CategoryRepository {
  final dbHelper = DatabaseHelper();

  /// Initialize the categories in the database to make them ready for usage.
  Future<void> initCategoriesData() async {
    await dbHelper.initCategories();
  }

  /// Inserts a new category into the database.
  Future<void> insertCategory(Category category) async {
    return dbHelper.saveCategory(category);
  }

  /// Returns a single category from the database.
  Future<Category> getCategory(String id) async {
    return dbHelper.getCategory(id);
  }

  /// Returns a list of all categories in the database.
  Stream<List<Category>> getCategories() {
    return dbHelper.getCategories();
  }

  /// Deletes a category from the database.
  Future<int> deleteCategory(Category category) async {
    return dbHelper.deleteCategory(category);
  }
}
