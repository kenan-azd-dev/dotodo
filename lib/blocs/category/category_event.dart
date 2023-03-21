import 'package:dotodo/data/model/category.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryOverviewEvent extends Equatable {
  const CategoryOverviewEvent();

  @override
  List<Object> get props => [];
}

class CategoryOverviewSubscriptionRequestedEvent extends CategoryOverviewEvent {
  const CategoryOverviewSubscriptionRequestedEvent();
}

class SaveCategoryEvent extends CategoryOverviewEvent {
  const SaveCategoryEvent({
    required this.category,
  });

  final Category category;

  @override
  List<Object> get props => [category];
}

class DeleteCategoryEvent extends CategoryOverviewEvent {
  const DeleteCategoryEvent({
    required this.category,
  });

  final Category category;

  @override
  List<Object> get props => [category];
}
