import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class TextFieldWithPopup extends StatefulWidget {
  const TextFieldWithPopup({
    super.key,
    required TextEditingController textEditingController,
    String? hintText,
    String? tooltip,
    void Function(dynamic)? onSelected,
  })  : _textEditingController = textEditingController,
        _hintText = hintText,
        _tooltip = tooltip,
        _onSelected = onSelected;

  final TextEditingController _textEditingController;
  final String? _hintText;
  final String? _tooltip;
  final void Function(dynamic)? _onSelected;

  @override
  State<TextFieldWithPopup> createState() => _TextFieldWithPopupState();
}

class _TextFieldWithPopupState extends State<TextFieldWithPopup> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      controller: widget._textEditingController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.background,
        hintText: widget._hintText,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSmallBorderRadius),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        suffixIcon: PopupMenuButton(
          icon: Icon(
            Icons.arrow_drop_down_rounded,
          ),
          onSelected: widget._onSelected,
          iconSize: 40,
          constraints: BoxConstraints(maxHeight: 200),
          tooltip: widget._tooltip,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kSmallBorderRadius)),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem<String>(
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: Container(
                  height: 200,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: listOfPopupMenuItems,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Cannot be empty';
        }
        return null;
      },
    );
  }
}
