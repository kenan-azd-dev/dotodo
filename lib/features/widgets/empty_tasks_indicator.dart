import 'package:dotodo/utils/constants.dart';
import 'package:flutter/material.dart';

class EmptyTasksIndicator extends StatelessWidget {
  const EmptyTasksIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          'You haven\'t added any tasks yet.\nStart adding some!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
