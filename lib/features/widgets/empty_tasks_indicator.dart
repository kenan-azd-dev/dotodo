import 'package:flutter/material.dart';
import '../../l10n/l10n.dart';
import '../../utils/constants.dart';

class EmptyTasksIndicator extends StatelessWidget {
  const EmptyTasksIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(kScreenMargin),
          child: Icon(
            Icons.note_alt_rounded,
            size: 50,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(
          l10n.yourTasksEmpty,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
