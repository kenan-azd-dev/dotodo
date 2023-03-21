import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants.dart';

import '../../../../blocs/category/category_bloc.dart';
import '../../../../blocs/category/category_state.dart';

import '../widgets/categories_horisontal_list_view.dart';
import '../widgets/theme_switcher.dart';
import '../../../widgets/error_indicator.dart';
import '../../../widgets/header.dart';

/// This is the part under the actual app bar,
/// where you can find the categories horizontal list view
/// and the welcoming message (Hello, User!)
class AppBarExtension extends StatelessWidget {
  const AppBarExtension({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.35,
      child: Stack(
        children: [
          Container(
            height: (size.height * 0.35) - (size.height / 6) / 2,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(kBigBorderRadius),
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(left: kScreenMargin, top: kSmallScreenMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Header(
                      text: 'Hello, Kenan!',
                      fontSize: 28,
                      isMargin: false,
                    ),
                    Spacer(),
                    ThemeSwitcher()
                  ],
                ),
              ],
            ),
          ),
          BlocBuilder<CategoriesOverviewBloc, CategoryOverviewState>(
            builder: (context, state) {
              if (state.categories.isEmpty) {
                if (state.status == CategoryOverviewStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == CategoryOverviewStatus.success) {
                  return CategoriesHorizontalListView(
                    items: state.categories,
                  );
                } else {
                  return ErrorIndicator();
                }
              }
              return CategoriesHorizontalListView(items: state.categories);
            },
          ),
        ],
      ),
    );
  }
}
