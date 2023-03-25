import 'package:dotodo/l10n/l10n.dart';
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
    final localization = context.l10n;

    return Container(
      margin: EdgeInsets.only(bottom: kScreenMargin),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.sentences,
        controller: _taskController,
        decoration: InputDecoration(
          hintText: localization.title,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return localization.titleError;
          }
          return null;
        },
      ),
    );
  }
}
