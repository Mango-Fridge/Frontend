import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/design.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/search_item_provider.dart';
import 'package:mango/state/search_item_state.dart';
import 'package:shimmer/shimmer.dart';

class SearchContentView extends ConsumerStatefulWidget {
  const SearchContentView({super.key});
  @override
  ConsumerState<SearchContentView> createState() => _SearchContentViewState();
}

class _SearchContentViewState extends ConsumerState<SearchContentView> {
  SearchItemState? get _searchContentState => ref.watch(searchContentProvider);

  final TextEditingController _controller = TextEditingController();
  final ScrollController _listViewScrollController = ScrollController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    // view init 후 데이터 처리를 하기 위함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(searchContentProvider.notifier).resetState();

      _listViewScrollController.addListener(() {
        final bool isNearBottom =
            _listViewScrollController.position.pixels >=
            _listViewScrollController.position.maxScrollExtent - 100;

        final bool canLoadMore =
            ref.read(searchContentProvider)?.hasMore ?? false;
        final bool isLoading =
            ref.read(searchContentProvider)?.isLoading ?? false;

        if (isNearBottom && !isLoading && canLoadMore) {
          ref
              .read(searchContentProvider.notifier)
              .loadItemListByString(_controller.text);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Design design = Design(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "물품 추가",
            style: TextStyle(fontSize: Design.normalFontSize4),
          ),
          scrolledUnderElevation: 0,
        ),
        body: Column(
          spacing: 20,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: design.marginAndPadding),
              padding: EdgeInsets.symmetric(
                horizontal: design.marginAndPadding * 1.5,
                vertical: design.marginAndPadding * 0.5,
              ),
              decoration: BoxDecoration(
                color: design.textFieldColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: design.textFieldborderColor,
                  width: 2,
                ),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(fontSize: Design.normalFontSize2),
                decoration: InputDecoration(
                  hintText: "ex) 초코칩",
                  border: InputBorder.none,
                ),
                onChanged: (String value) {
                  _onSearchChanged(value);
                },
              ),
            ),
            Expanded(
              child:
                  _searchContentState != null &&
                          _searchContentState?.refrigeratorItemList != null &&
                          _searchContentState!
                              .refrigeratorItemList!
                              .isNotEmpty &&
                          _controller.text != ''
                      ? _buildItem(_searchContentState?.refrigeratorItemList!)
                      : _noItemView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(List<RefrigeratorItem>? itemList) {
    final Design design = Design(context);
    return Column(
      children: <Widget>[
        Expanded(
          child:
              (ref.watch(searchContentProvider)?.isLoading ?? false)
                  ? ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: design.marginAndPadding,
                            horizontal: design.marginAndPadding,
                          ),
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                  )
                  : ListView.builder(
                    controller: _listViewScrollController,
                    itemCount: itemList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final RefrigeratorItem item = itemList![index];
                      return _buildItemRow(item);
                    },
                  ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildItemRow(RefrigeratorItem item) {
    Design design = Design(context);
    return GestureDetector(
      onTap: () async {
        try {
          RefrigeratorItem? loadedItem = await ref
              .read(searchContentProvider.notifier)
              .loadItem(item.itemId ?? 0);
          context.push('/addContent', extra: loadedItem);
        } catch (e) {
          AppLogger.logger.e('[search_item_view/_buildItemRow]: $e');
        }

        ref.watch(searchContentProvider.notifier).resetState();
        _controller.text = '';
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: design.marginAndPadding,
          horizontal: design.marginAndPadding,
        ),
        padding: EdgeInsets.only(
          left: design.marginAndPadding * 1.5,
          right: design.marginAndPadding * 1.5,
          top: design.marginAndPadding * 1.3,
          bottom: design.marginAndPadding * 1.3,
        ),
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
  }

  // 이름 및 브랜드 표기
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

  // 용량 및 칼로리 표기
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

  // 검색어에 의한 물품이 없을 시 화면
  Widget _noItemView() {
    Design design = Design(context);

    return Column(
      children: <Widget>[
        const SizedBox(height: 100),
        Image.asset(
          "assets/images/cart.png",
          width: design.cartImageSize,
          height: design.cartImageSize,
        ),
        const Text(
          "찾고 싶은 물품을 검색하거나,\n원하는 물품이 없다면 직접 추가해 보세요!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Design.normalFontSize1),
        ),
        ElevatedButton(
          onPressed: () {
            context.push('/addContent');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[300],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("직접 물품 추가"),
        ),
        const Spacer(),
      ],
    );
  }

  void _onSearchChanged(String keyword) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref
          .read(searchContentProvider.notifier)
          .loadItemListByString(keyword, isRefresh: true);
    });
  }
}
