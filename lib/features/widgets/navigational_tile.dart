import 'package:dotodo/utils/constants.dart';
import 'package:dotodo/features/widgets/sub_header.dart';
import 'package:flutter/material.dart';

class NavigationalTile extends StatelessWidget {
  const NavigationalTile({
    super.key,
    required title,
    bool isScaffoldBackground = false,
    void Function()? onTap,
  })  : _title = title,
        _isScaffoldBackground = isScaffoldBackground,
        _onTap = onTap;

  final String _title;
  final bool _isScaffoldBackground;
  final void Function()? _onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isScaffoldBackground
          ? Theme.of(context).scaffoldBackgroundColor
          : Theme.of(context).colorScheme.onSecondary,
      borderRadius: BorderRadius.circular(kSmallBorderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(kSmallBorderRadius),
        onTap: _onTap,
        child: Row(
          children: [
            SubHeader(
              _title,
              isBold: true,
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
