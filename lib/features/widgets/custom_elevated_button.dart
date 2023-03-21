import 'package:dotodo/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required Widget child,
    required void Function()? onPressed,
  })  : _child = child,
        _onPressed = onPressed;

  final Widget _child;
  final void Function()? _onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kScreenMargin),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background),
      ),
      onPressed: _onPressed,
      child: _child,
    );
  }
}
