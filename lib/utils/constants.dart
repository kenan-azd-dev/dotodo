import 'package:flutter/material.dart';

double kScreenMargin = 20.0;

double kSmallScreenMargin = 14.0;

double kSmallBorderRadius = 20.0;

double kBigBorderRadius = 46.0;

double kBottomSheetMaxHeightFraction = 0.6;
double kBottomSheetMinHeightFraction = 0.1;

List<Widget> listOfPopupMenuItems = <Widget>[
  const PopupMenuItem(
    value: 'Personal',
    child: Text('Personal'),
  ),
  const PopupMenuItem(
    value: 'Work',
    child: Text('Work'),
  ),
  const PopupMenuItem(
    value: 'Family',
    child: Text('Family'),
  ),
  const PopupMenuItem(
    value: 'Urgent',
    child: Text('Urgent'),
  ),
  const PopupMenuItem(
    value: 'Important',
    child: Text('Important'),
  ),
];

class Constants {
  static double deviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double deviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
