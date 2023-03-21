import 'package:flutter/material.dart';

import '../../utils/constants.dart';

import '../widgets/custom_elevated_button.dart';
import '../widgets/header.dart';
import '../widgets/sub_header.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required IconData iconData,
    required String title,
    required Widget content,
    required void Function()? onPressed,
  })  : _iconData = iconData,
        _title = title,
        _content = content,
        _onPressed = onPressed;

  final IconData _iconData;
  final String _title;
  final Widget _content;
  final void Function()? _onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      icon: Icon(
        _iconData,
        size: 40,
        color: _iconData == Icons.delete_rounded
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).iconTheme.color,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kScreenMargin)),
      title: Header(
        text: _title,
        isMargin: false,
        color: _iconData == Icons.delete_rounded
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).iconTheme.color,
      ),
      content: _content,
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: SubHeader('No'),
        ),
        CustomElevatedButton(
          child: SubHeader('Yes!'),
          onPressed: _onPressed,
        ),
      ],
    );
  }
}
