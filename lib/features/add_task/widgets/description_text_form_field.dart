
import 'package:dotodo/utils/constants.dart';
import 'package:flutter/material.dart';

class DescriptionTextFormField extends StatelessWidget {
  const DescriptionTextFormField({
    super.key,
    required TextEditingController descriptionController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kScreenMargin),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: _descriptionController,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Task\'s description (optional)',
        ),
      ),
    );
  }
}
