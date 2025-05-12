import 'package:flutter/material.dart';
import 'package:mango/design.dart';
import 'package:mango/model/refrigerator_item.dart';

class SearchItemListView extends StatelessWidget {
  final List<RefrigeratorItem> itemList;
  final bool isLoadingMore;
  final bool hasMore;
  final ScrollController? scrollController;
  final void Function(RefrigeratorItem item) onItemTap;

  const SearchItemListView({
    super.key,
    required this.itemList,
    required this.isLoadingMore,
    required this.hasMore,
    this.scrollController,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    return ListView.builder(
      controller: scrollController,
      itemCount: itemList.length + (hasMore && isLoadingMore ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == itemList.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final RefrigeratorItem item = itemList[index];
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onItemTap(item),
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: design.marginAndPadding / 3,
              horizontal: design.marginAndPadding,
            ),
            padding: EdgeInsets.all(design.marginAndPadding),
            decoration: BoxDecoration(
              color: design.subColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: design.mainColor, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _nameAndBrandText(item.itemName, Design.normalFontSize2),
                      _nameAndBrandText(item.brandName, Design.normalFontSize1),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    _capacityAndKcalRow(
                      '용량 : ',
                      '${item.nutriCapacity}${item.nutriUnit}',
                    ),
                    _capacityAndKcalRow('칼로리 : ', '${item.nutriKcal}kcal'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _nameAndBrandText(String? text, double fontSize) {
    final String displayText =
        (text ?? '').length > 10
            ? '${(text ?? '').substring(0, 10)}...'
            : text ?? '';
    return Text(
      displayText,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _capacityAndKcalRow(String info, String value) {
    return Row(
      children: <Widget>[
        Text(
          info,
          style: const TextStyle(
            fontSize: Design.normalFontSize1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value, style: const TextStyle(fontSize: Design.normalFontSize1)),
      ],
    );
  }
}
