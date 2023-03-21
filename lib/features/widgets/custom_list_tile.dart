import 'package:flutter/material.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

import '../../utils/constants.dart';

import './sub_header.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required Future<bool?> Function(SwipeDirection)? confirmSwipe,
    required Key valueKey,
    required String title,
    String? toolTip,
    required void Function(SwipeDirection) onSwiped,
    void Function()? onTap,
    required Widget trailing,
  })  : _valueKey = valueKey,
        _title = title,
        _toolTip = toolTip,
        _onTap = onTap,
        _onSwiped = onSwiped,
        _confirmSwipe = confirmSwipe,
        _trailing = trailing;

  final Key _valueKey;
  final String _title;
  final String? _toolTip;
  final void Function(SwipeDirection) _onSwiped;
  final void Function()? _onTap;
  final Future<bool?> Function(SwipeDirection)? _confirmSwipe;
  final Widget _trailing;

  @override
  Widget build(BuildContext context) {
    return SwipeableTile.card(
      confirmSwipe: _confirmSwipe,
      key: _valueKey,
      borderRadius: kSmallBorderRadius,
      backgroundBuilder: (context, direction, progress) {
        return Container(
          padding: EdgeInsets.only(right: kScreenMargin),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
          ),
          child: Icon(
            Icons.delete_rounded,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
        );
      },
      horizontalPadding: 20,
      verticalPadding: 10,
      shadow: BoxShadow(
        offset: Offset(0, 10),
        blurRadius: 10,
        blurStyle: BlurStyle.normal,
        color: Colors.black26,
      ),
      color: Colors.white,
      onSwiped: _onSwiped,
      child: Material(
        child: InkWell(
          onTap: _onTap,
          child: Container(
            height: 100,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(kSmallBorderRadius),
                      topLeft: Radius.circular(kSmallBorderRadius),
                    ),
                  ),
                  width: 40,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SubHeader(_title),
                    ],
                  ),
                ),
                const Spacer(),
                Tooltip(
                  message: _toolTip,
                  child: _trailing,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
