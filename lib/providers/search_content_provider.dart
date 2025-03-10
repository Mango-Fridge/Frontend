import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/services/item_repository.dart';

class SearchContentState {
  List<RefrigeratorItem>? refrigeratorItemList;

  SearchContentState({this.refrigeratorItemList});

  SearchContentState copyWith({List<RefrigeratorItem>? refrigeratorItemList}) {
    return SearchContentState(
      refrigeratorItemList: refrigeratorItemList ?? this.refrigeratorItemList,
    );
  }
}

class SearchContentNotifier extends Notifier<SearchContentState?> {
  final ItemRepository _itemRepository = ItemRepository();
  final SearchContentState _searchContentState = SearchContentState();

  @override
  SearchContentState? build() => null;

  Future<void> loadItemListByString(String searchTerm) async {
    final List<RefrigeratorItem> refrigeratorList = await _itemRepository
        .loadItemListByString(searchTerm);
    try {
      _searchContentState.refrigeratorItemList = refrigeratorList;
      state = _searchContentState;
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
