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

class SearchContentProvider extends Notifier<SearchContentState?> {
  final ItemRepository _itemRepository = ItemRepository();

  @override
  SearchContentState? build() => null;

  Future<void> loadItemListByString(String searchTerm) async {
    List<RefrigeratorItem> refrigeratorList = await _itemRepository
        .loadItemListByString(searchTerm);
    state = state?.copyWith(refrigeratorItemList: refrigeratorList);
  }
}
