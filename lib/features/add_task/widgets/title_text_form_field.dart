
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class TitleTextFormField extends StatelessWidget {
  const TitleTextFormField({
    super.key,
    required TextEditingController taskController,
  }) : _taskController = taskController;

  final TextEditingController _taskController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kScreenMargin),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.sentences,
        controller: _taskController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.background,
          hintText: 'Task\'s title',
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kSmallBorderRadius),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2.0,),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kSmallBorderRadius),
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Title could not be empty';
          }
          return null;
        },
      ),
    );
  }
}
