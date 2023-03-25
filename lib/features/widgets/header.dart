import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required text,
    double? fontSize = 24.0,
    bool? isMargin = true,
    bool isCentered = false,
    Color? color,
  })  : _text = text,
        _fontSize = fontSize,
        _isMargin = isMargin,
        _isCentered = isCentered,
        _color = color;
  final String _text;
  final double? _fontSize;
  final bool? _isMargin;
  final bool _isCentered;
  final Color? _color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _isMargin! ? EdgeInsets.all(kScreenMargin) : null,
      child: Text(
        _text,
        textAlign: _isCentered ? TextAlign.center : null,
        maxLines: 1,
        style: TextStyle(
          color: _color,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: _fontSize,
        ),
      ),
    );
  }
}
