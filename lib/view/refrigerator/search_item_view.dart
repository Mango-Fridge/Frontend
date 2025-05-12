import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/design.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/search_item_provider.dart';
import 'package:mango/state/search_item_state.dart';
import 'package:mango/view/search_result_view.dart';

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
              child: SearchResultView(
                controller: _controller,
                searchState: _searchContentState,
                isSearching:
                    ref.watch(searchContentProvider)?.isSearching ?? false,
                scrollController: _listViewScrollController,
                onItemTap: (RefrigeratorItem item) async {
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
              ),
            ),
          ],
        ),
      ),
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
