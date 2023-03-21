import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/category/category_bloc.dart';
import '../../../blocs/category/category_event.dart';

import '../../../utils/constants.dart';

import '../../../data/model/models.dart';

import '../../widgets/header.dart';
import '../../widgets/text_field_with_popup.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({
    super.key,
    DraggableScrollableController? controller,
  }) : _controller = controller;

  final DraggableScrollableController? _controller;

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kScreenMargin).copyWith(top: 0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(64),
          topRight: Radius.circular(64),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                if (widget._controller != null) {
                  double animateToThisHeight;
                  if (widget._controller!.size ==
                      kBottomSheetMaxHeightFraction) {
                    animateToThisHeight = kBottomSheetMinHeightFraction;
                  } else if (widget._controller!.size ==
                      kBottomSheetMinHeightFraction) {
                    animateToThisHeight = kBottomSheetMaxHeightFraction;
                  } else {
                    return;
                  }
                  await widget._controller!.animateTo(
                    animateToThisHeight,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linearToEaseOut,
                  );
                  setState(() {});
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Header(text: 'Add Category'),
                  widget._controller != null
                      ? Icon(
                          widget._controller!.size ==
                                  kBottomSheetMaxHeightFraction
                              ? Icons.arrow_drop_down_rounded
                              : Icons.arrow_drop_up_rounded,
                          size: 40,
                        )
                      : SizedBox()
                ],
              ),
            ),
            TextFieldWithPopup(
              textEditingController: _textEditingController,
              hintText: 'Category\'s name',
              tooltip: 'Example categories',
              onSelected: (value) {
                setState(() {
                  _textEditingController.text = value;
                });
              },
            ),
            Container(
              margin: EdgeInsets.all(kSmallScreenMargin),
              child: ElevatedButton(
                onPressed: _textEditingController.text.isEmpty
                    ? null
                    : () {
                        context.read<CategoriesOverviewBloc>().add(
                              SaveCategoryEvent(
                                category: Category(
                                  id: Uuid().v1(),
                                  name: _textEditingController.text,
                                ),
                              ),
                            );
                      },
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 16),
                ),
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(80, 50)),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kSmallBorderRadius),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
