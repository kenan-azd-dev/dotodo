import 'package:dotodo/blocs/category/category_bloc.dart';
import 'package:dotodo/blocs/category/category_event.dart';
import 'package:dotodo/data/model/category.dart';
import 'package:dotodo/features/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/text_field_with_popup.dart';

class EditCategoryView extends StatefulWidget {
  const EditCategoryView({
    super.key,
    required Category category,
  }) : _category = category;

  final Category _category;

  @override
  State<EditCategoryView> createState() => _EditCategoryViewState();
}

class _EditCategoryViewState extends State<EditCategoryView> {
  final _categoryController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _categoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      iconData: Icons.edit_rounded,
      title: 'Edit Category',
      content: TextFieldWithPopup(
        textEditingController: _categoryController,
        onSelected: (value) {
          _categoryController.text = value;
        },
      ),
      onPressed: () {
        context.read<CategoriesOverviewBloc>().add(
              SaveCategoryEvent(
                category: Category(
                  id: widget._category.id,
                  name: _categoryController.text,
                ),
              ),
            );
        Navigator.of(context).pop();
      },
    );
  }
}
