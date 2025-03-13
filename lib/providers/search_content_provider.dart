import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/services/item_repository.dart';
import 'package:mango/state/search_content_state.dart';

class SearchContentNotifier extends Notifier<SearchContentState?> {
  final ItemRepository _itemRepository = ItemRepository();
  SearchContentState _searchContentState = SearchContentState();

  @override
  SearchContentState? build() => null;

  // 초기화 함수
  void resetState() {
    _searchContentState = SearchContentState();
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

final NotifierProvider<SearchContentNotifier, SearchContentState?>
searchContentNotifier =
    NotifierProvider<SearchContentNotifier, SearchContentState?>(
      SearchContentNotifier.new,
    );
