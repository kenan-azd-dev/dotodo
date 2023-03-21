import 'package:bloc/bloc.dart';

import '../../data/model/category.dart';
import '../../data/repositories/category_repository.dart';

import './category_state.dart';
import './category_event.dart';

class CategoriesOverviewBloc
    extends Bloc<CategoryOverviewEvent, CategoryOverviewState> {
  CategoriesOverviewBloc({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(const CategoryOverviewState()) {
    on<CategoryOverviewSubscriptionRequestedEvent>(_onSubscriptionRequested);
    on<SaveCategoryEvent>(_onCategorySaved);
    on<DeleteCategoryEvent>(_onCategoryDeleted);
  }
  final CategoryRepository _categoryRepository;

  Future<void> _onSubscriptionRequested(
    CategoryOverviewSubscriptionRequestedEvent event,
    Emitter<CategoryOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => CategoryOverviewStatus.loading));
    await emit.forEach<List<Category>>(
      _categoryRepository.getCategories(),
      onData: (categories) => state.copyWith(
        status: () => CategoryOverviewStatus.success,
        categories: () => categories,
      ),
      onError: (_, __) => state.copyWith(
        status: () => CategoryOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onCategorySaved(
    SaveCategoryEvent event,
    Emitter<CategoryOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => CategoryOverviewStatus.loading));
    final newCategory = event.category;
    await _categoryRepository.insertCategory(newCategory);
  }

  Future<void> _onCategoryDeleted(
    DeleteCategoryEvent event,
    Emitter<CategoryOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => CategoryOverviewStatus.loading));
    final category = event.category;
    await _categoryRepository.deleteCategory(category);
  }
}
