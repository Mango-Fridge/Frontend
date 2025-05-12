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

      bool _isFetchingNextPage = false;

      _listViewScrollController.addListener(() {
        final bool isNearBottom =
            _listViewScrollController.position.pixels >=
            _listViewScrollController.position.maxScrollExtent - 100;

        final bool canLoadMore =
            ref.read(searchContentProvider)?.hasMore ?? false;
        final bool isLoading =
            ref.read(searchContentProvider)?.isLoading ?? false;
        final bool isLoadingMore =
            ref.read(searchContentProvider)?.isLoadingMore ?? false;

        if (isNearBottom && !isLoading && !isLoadingMore && canLoadMore) {
          _isFetchingNextPage = true;

          ref
              .read(searchContentProvider.notifier)
              .loadItemListByString(_controller.text)
              .whenComplete(() => _isFetchingNextPage = false);
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
            style: TextStyle(fontSize: Design.normalFontSize2),
          ),
          scrolledUnderElevation: 0,
        ),
        body: Column(
          spacing: 20,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: design.marginAndPadding),
              padding: EdgeInsets.only(
                left: design.marginAndPadding,
                top: design.marginAndPadding * 0.5,
                bottom: design.marginAndPadding * 0.5,
              ),
              decoration: BoxDecoration(
                color: design.textFieldColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: design.textFieldborderColor),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(fontSize: Design.normalFontSize2),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: "ex) 초코칩",
                  border: InputBorder.none,
                  suffix:
                      (_controller.text.isNotEmpty)
                          ? GestureDetector(
                            onTap: () {
                              _controller.clear();
                              _onSearchChanged('');
                              FocusScope.of(context).unfocus();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: design.marginAndPadding,
                              ),
                              child: const Icon(
                                Icons.clear,
                                color: Colors.red,
                                size: 18,
                              ),
                            ),
                          )
                          : null,
                ),
                onChanged: (String value) {
                  _onSearchChanged(value);
                },
              ),
            ),
            Expanded(
              child:
                  (ref.watch(searchContentProvider)?.isSearching ?? false)
                      ? _buildSkeleton()
                      : _controller.text != ''
                      ? (_searchContentState != null &&
                              _searchContentState?.refrigeratorItemList !=
                                  null &&
                              _searchContentState!
                                  .refrigeratorItemList!
                                  .isNotEmpty)
                          ? _buildItem(
                            _searchContentState?.refrigeratorItemList!,
                          )
                          : (_searchContentState != null &&
                              _searchContentState?.refrigeratorItemList !=
                                  null &&
                              _searchContentState!
                                  .refrigeratorItemList!
                                  .isEmpty)
                          ? _noItemView() // 항목은 있지만 내용이 없는 경우
                          : _noItemView() // 항목 자체가 없는 경우
                      : (_searchContentState != null &&
                          _searchContentState?.refrigeratorItemList != null &&
                          _searchContentState!.refrigeratorItemList!.isEmpty)
                      ? _noSearchView() // 텍스트가 없고 항목이 비어있는 경우
                      : _noSearchView(), // 텍스트가 없고 항목도 없을 때
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(List<RefrigeratorItem>? itemList) {
    final Design design = Design(context);
    final bool hasMore = _searchContentState?.hasMore ?? false;
    final bool isLoadingMore = _searchContentState?.isLoadingMore ?? false;

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
                    itemCount:
                        (itemList?.length ?? 0) +
                        (hasMore && isLoadingMore ? 1 : 0),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == itemList?.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
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

  // 검색어를 입력하지 않았을 때의 화면
  Widget _noSearchView() {
    Design design = Design(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: <Widget>[
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
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            "직접 물품 추가",
            style: TextStyle(fontSize: Design.normalFontSize1),
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  // 검색어에 의한 물품이 없을 시 화면
  Widget _noItemView() {
    Design design = Design(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: <Widget>[
        Image.asset(
          "assets/images/null_item.png",
          width: design.cartImageSize,
          height: design.cartImageSize,
        ),
        const Text(
          "검색어에 해당하는 물품이 없습니다.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Design.normalFontSize1),
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  void _onSearchChanged(String keyword) {
    if (keyword.isEmpty) {
      ref.read(searchContentProvider.notifier).resetState();
      return;
    }

    ref.read(searchContentProvider.notifier).setSearching(true);

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      await ref
          .read(searchContentProvider.notifier)
          .loadItemListByString(keyword, isRefresh: true);
      ref.read(searchContentProvider.notifier).setSearching(false);
    });
  }
}
