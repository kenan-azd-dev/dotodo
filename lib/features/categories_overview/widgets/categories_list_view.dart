import 'package:dotodo/features/edit_category/edit_category.dart';
import 'package:dotodo/features/widgets/custom_dialog.dart';
import 'package:dotodo/features/widgets/sub_header.dart';

import '../../../features/tasks_by_category/tasks_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/category/category_bloc.dart';
import '../../../blocs/category/category_event.dart';

import '../../../data/model/category.dart';

import '../../widgets/custom_list_tile.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
    required List<Category> items,
  }) : _items = items;

  final List<Category> _items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return CustomListTile(
          confirmSwipe: (_) async {
            bool confirm = false;
            await showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  iconData: Icons.delete_rounded,
                  title: 'Confirm Deletion',
                  content: SubHeader(
                      'Are you sure you want to delete this category?\nAll the tasks that falls under this category will be deleted too.'),
                  onPressed: () {
                    confirm = true;
                    Navigator.of(context).pop();
                  },
                );
              },
            );
            return confirm;
          },
          valueKey: ValueKey<String>(_items[index].id),
          title: _items[index].name,
          toolTip: 'Edit category',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return TasksByCategory(
                    category: _items[index],
                  );
                },
              ),
            );
          },
          trailing: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return EditCategoryView(category: _items[index]);
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(Icons.edit_rounded),
            ),
          ),
          onSwiped: (_) {
            context.read<CategoriesOverviewBloc>().add(
                  DeleteCategoryEvent(
                    category: _items[index],
                  ),
                );
          },
        );
      },
    );
  }
}
