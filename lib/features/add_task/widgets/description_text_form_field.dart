
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
          filled: true,
          fillColor: Theme.of(context).colorScheme.background,
          hintText: 'Task\'s description (optional)',
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kSmallBorderRadius),
            borderSide:
                BorderSide(color: Colors.blueGrey, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kSmallBorderRadius),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
      ),
    );
  }
}
