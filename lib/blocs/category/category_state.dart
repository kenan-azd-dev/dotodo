import 'package:equatable/equatable.dart';

import '../../data/model/category.dart';

enum CategoryOverviewStatus { initial, loading, success, failure }

class CategoryOverviewState extends Equatable {
  const CategoryOverviewState({
    this.status = CategoryOverviewStatus.initial,
    this.categories = const [],
  });

  final CategoryOverviewStatus status;
  final List<Category> categories;

  @override
  List<Object?> get props => [
        status,
        categories,
      ];

  CategoryOverviewState copyWith({
    CategoryOverviewStatus Function()? status,
    List<Category> Function()? categories,
  }) {
    return CategoryOverviewState(
      status: status != null ? status() : this.status,
      categories: categories != null ? categories() : this.categories,
    );
  }
}
