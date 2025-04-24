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
    if (state?.isLoading == true) return;

    state = state?.copyWith(isLoading: true);

    try {
      final int currentPage = isRefresh ? 0 : state?.page ?? 0;
      final List<RefrigeratorItem> newList = await _itemRepository
          .loadItemListByString(keyword, currentPage);

      List<RefrigeratorItem> updatedList = <RefrigeratorItem>[];
      if (!isRefresh) {
        updatedList = <RefrigeratorItem>[
          ...?state?.refrigeratorItemList,
          ...newList,
        ];
      } else {
        updatedList = newList;
      }

      final int nextPage = newList.isNotEmpty ? currentPage + 1 : currentPage;
      final bool hasMore = newList.isNotEmpty;

      state = state?.copyWith(
        refrigeratorItemList: updatedList,
        page: nextPage,
        isLoading: false,
        hasMore: hasMore,
      );
    } catch (e) {
      AppLogger.logger.e("[search_item_provider/loadItemListByString] $e");
      state = state?.copyWith(isLoading: false);
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

  Future<bool> deleteItem(int cookItemId) async {
    try {
      await _itemRepository.deleteItem(cookItemId);
      if (state?.refrigeratorItemList != null) {
        final updatedList =
            state!.refrigeratorItemList!
                .where((i) => i.itemId != cookItemId)
                .toList();
        state = state!.copyWith(refrigeratorItemList: updatedList);
        AppLogger.logger.d(
          "[search_item_provider/deleteItem]: Item deleted successfully, ID: $cookItemId",
        );
        return true;
      }
      AppLogger.logger.w(
        "[search_item_provider/deleteItem]: No items to update.",
      );
      return false; // 상태가 없거나 리스트가 비어있으면 실패로 간주
    } catch (e) {
      AppLogger.logger.e(
        "[search_item_provider/deleteItem]: Failed to delete item, ID: $cookItemId, Error: $e",
      );
      return false;
    }
  }
}

final NotifierProvider<SearchItemNotifier, SearchItemState?>
searchContentProvider = NotifierProvider<SearchItemNotifier, SearchItemState?>(
  SearchItemNotifier.new,
);
