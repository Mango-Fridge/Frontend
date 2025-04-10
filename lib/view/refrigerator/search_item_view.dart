import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/design.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/search_item_provider.dart';
import 'package:mango/state/search_item_state.dart';

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
        appBar: AppBar(title: const Text("물품 추가"), scrolledUnderElevation: 0),
        body: Column(
          spacing: 20,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: design.marginAndPadding),
              padding: EdgeInsets.symmetric(
                horizontal: design.marginAndPadding,
              ),
              decoration: BoxDecoration(
                color: Colors.amber[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
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
    return Container(
      child: Column(
        children: <Widget>[
          const Divider(),
          Expanded(
            child: ListView.builder(
              controller: _listViewScrollController,
              itemCount: itemList?.length,
              itemBuilder: (BuildContext context, int index) {
                final RefrigeratorItem item = itemList![index];
                return _buildItemRow(item);
              },
            ),
          ),
          const Divider(),
        ],
      ),
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
          vertical: 4,
          horizontal: design.marginAndPadding,
        ),
        padding: EdgeInsets.all(design.marginAndPadding),
        decoration: BoxDecoration(
          color: Colors.amber[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    (item.itemName ?? '').length > 10
                        ? '${(item.itemName ?? '').substring(0, 10)}...'
                        : item.itemName ?? '',
                    style: const TextStyle(
                      fontSize: Design.normalFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${item.nutriCapacity}${item.nutriUnit} / ${item.nutriKcal}kcal',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  (item.brandName ?? '').length > 10
                      ? '${(item.brandName ?? '').substring(0, 10)}...'
                      : item.brandName ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
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
          style: TextStyle(fontSize: Design.normalFontSize),
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
