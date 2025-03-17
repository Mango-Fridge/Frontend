import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/services/item_repository.dart';
import 'package:mango/state/search_item_state.dart';

class SearchItemNotifier extends Notifier<SearchItemState?> {
  final ItemRepository _itemRepository = ItemRepository();
  SearchItemState _searchContentState = SearchItemState();

  @override
  SearchItemState? build() => null;

  // 초기화 함수
  void resetState() {
    _searchContentState = SearchItemState();
    state = _searchContentState;
  }

  // 검색어로 부터 Item list load 함수
  Future<void> loadItemListByString(String searchTerm) async {
    final List<RefrigeratorItem> refrigeratorList = await _itemRepository
        .loadItemListByString(searchTerm);
    try {
      state = state?.copyWith(refrigeratorItemList: refrigeratorList);
    } catch (e) {
      state = null;
    }
  }
}

final NotifierProvider<SearchItemNotifier, SearchItemState?>
searchContentNotifier = NotifierProvider<SearchItemNotifier, SearchItemState?>(
  SearchItemNotifier.new,
);
