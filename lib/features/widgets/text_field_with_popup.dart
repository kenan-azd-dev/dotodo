import 'package:dotodo/l10n/l10n.dart';
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
    final localization = context.l10n;
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      controller: widget._textEditingController,
      decoration: InputDecoration(
        hintText: widget._hintText,
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
          return localization.categoryError1;
        }
        return null;
      },
    );
  }
}
