import 'package:dotodo/utils/navigate_to.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/models.dart';

import '../../../../utils/constants.dart';

import '../../../widgets/navigational_tile.dart';
import '../widgets/horizontal_category_item.dart';

import '../../../add_category/add_category.dart';

class CategoriesHorizontalListView extends StatelessWidget {
  const CategoriesHorizontalListView({
    super.key,
    required items,
  }) : _items = items;

  final List<Category> _items;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                left: kScreenMargin, bottom: 14, right: kScreenMargin),
            child: _items.isEmpty
                ? Text(
                    'You have no categories yet.\nStart adding some!',
                    style: TextStyle(fontSize: 18),
                  )
                : NavigationalTile(
                    title: 'Categories',
                    onTap: () => Navigator.of(context)
                        .pushNamed(NavigateTo.categoriesPage),
                  ),
          ),
          _items.length == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 6,
                      width: size.width / 2.5,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return AddCategoryPage();
                            },
                          );
                        },
                        child: Icon(Icons.add_rounded),
                        style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(80, 60)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(kSmallBorderRadius),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(
                  height: Constants.deviceHeight(context) / 6,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: _items.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return HorizontalCategoryItem(
                        item: _items[index],
                        index: index,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
