import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/services/item_repository.dart';
import 'package:mango/state/search_item_state.dart';

class SearchItemNotifier extends Notifier<SearchItemState?> {
  final ItemRepository _itemRepository = ItemRepository();
  SearchItemState _searchContentState = SearchItemState();

  @override
  SearchItemState? build() => SearchItemState();

  // 초기화 함수
  void resetState() {
    _searchContentState = SearchItemState();
    state = _searchContentState;
  }

  // 검색어로 부터 Item list load 함수
  Future<void> loadItemListByString(
    String keyword, {
    bool isRefresh = false,
  }) async {
    if ((isRefresh && state?.isLoading == true) ||
        (!isRefresh && state?.isLoadingMore == true))
      return;

    try {
      if (isRefresh) {
        state = state?.copyWith(isLoading: true);
      } else {
        state = state?.copyWith(isLoadingMore: true);
      }

      final int currentPage = isRefresh ? 0 : state?.page ?? 0;

      final List<RefrigeratorItem> newList = await _itemRepository
          .loadItemListByString(keyword, currentPage);

      List<RefrigeratorItem> updatedList = <RefrigeratorItem>[];
      if (isRefresh) {
        updatedList = newList;
      } else {
        updatedList = <RefrigeratorItem>[
          ...?state?.refrigeratorItemList,
          ...newList,
        ];
      }

      final int nextPage = newList.isNotEmpty ? currentPage + 1 : currentPage;
      final bool hasMore = newList.isNotEmpty;

      state = state?.copyWith(
        refrigeratorItemList: updatedList,
        page: nextPage,
        hasMore: hasMore,
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      AppLogger.logger.e("[search_item_provider/loadItemListByString] $e");

      state = state?.copyWith(isLoading: false, isLoadingMore: false);
    }
  }

  // itemId로 개별 item 불러오는 함수
  Future<RefrigeratorItem?> loadItem(int itemId) async {
    try {
      final RefrigeratorItem? item = await _itemRepository.loadItem(itemId);

      return item;
    } catch (e) {
      AppLogger.logger.e("[search_item_provider/loadItemListByString]: $e");
    }
  }

  void setLoading(bool loading) {
    state = state?.copyWith(isLoading: loading);
  }

  void setSearching(bool value) {
    state = state?.copyWith(isSearching: value);
  }
}

final NotifierProvider<SearchItemNotifier, SearchItemState?>
searchContentProvider = NotifierProvider<SearchItemNotifier, SearchItemState?>(
  SearchItemNotifier.new,
);
