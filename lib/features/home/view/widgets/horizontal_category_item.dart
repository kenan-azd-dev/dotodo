import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
import '../../../../data/model/category.dart';
import '../../../../features/tasks_by_category/tasks_by_category.dart';
import '../../../widgets/sub_header.dart';

class HorizontalCategoryItem extends StatelessWidget {
  const HorizontalCategoryItem({
    super.key,
    required Category item,
    required int index,
  })  : _item = item,
        _index = index;

  final Category _item;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _index == 0
          ? EdgeInsets.only(
              left: kScreenMargin,
              right: kSmallScreenMargin,
              bottom: kScreenMargin)
          : EdgeInsets.only(right: kSmallScreenMargin, bottom: kScreenMargin),
      width: Constants.deviceWidth(context) / 2.5,
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(kSmallBorderRadius),
        color: Theme.of(context).colorScheme.secondary,
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.circular(kSmallBorderRadius),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TasksByCategory(category: _item),
                ),
              );
            },
            child: Center(
              child: SubHeader(_item.name),
            ),
          ),
        ),
      ),
    );
  }
}
