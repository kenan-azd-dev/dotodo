import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../add_category/add_category.dart';
import '../../widgets/error_indicator.dart';
import '../widgets/categories_list_view.dart';

import '../../../blocs/category/category_bloc.dart';
import '../../../blocs/category/category_state.dart';

class CategoriesOverviewView extends StatefulWidget {
  const CategoriesOverviewView({super.key});

  @override
  State<CategoriesOverviewView> createState() => _CategoriesOverviewViewState();
}

class _CategoriesOverviewViewState extends State<CategoriesOverviewView> {
  final controller = DraggableScrollableController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Categories'),
          ),
          body: BlocBuilder<CategoriesOverviewBloc, CategoryOverviewState>(
            builder: (context, state) {
              if (state.categories.isEmpty) {
                if (state.status == CategoryOverviewStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == CategoryOverviewStatus.success) {
                  return Center(
                    child: Text(
                        'You haven\'t added any categories yet!\nStart adding some.'),
                  );
                } else {
                  return Center(
                    child: ErrorIndicator(),
                  );
                }
              }
              return CategoriesListView(
                items: state.categories,
              );
            },
          ),
        ),
        DraggableScrollableSheet(
          snap: true,
          initialChildSize: 0.10,
          minChildSize: 0.10,
          maxChildSize: 0.6,
          controller: controller,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: AddCategoryPage(controller: controller),
            );
          },
        ),
      ],
    );
  }
}



