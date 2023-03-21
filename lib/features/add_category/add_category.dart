import 'package:dotodo/features/add_category/view/add_category_view.dart';
import 'package:flutter/material.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({
    super.key,
    DraggableScrollableController? controller,
  }) : _controller = controller;
  final DraggableScrollableController? _controller;

  @override
  Widget build(BuildContext context) {
    return AddCategoryView(
      controller: _controller,
    );
  }
}
