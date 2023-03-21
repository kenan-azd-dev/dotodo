import 'package:flutter/material.dart';

class SubHeader extends StatelessWidget {
  const SubHeader(String text, {bool isBold = false, super.key})
      : _text = text,
        _isBold = isBold;
  final String _text;
  final bool _isBold;

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
