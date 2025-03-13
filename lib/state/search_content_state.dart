import 'package:mango/model/refrigerator_item.dart';

class SearchContentState {
  List<RefrigeratorItem>? refrigeratorItemList;

  SearchContentState({this.refrigeratorItemList});

  SearchContentState copyWith({List<RefrigeratorItem>? refrigeratorItemList}) {
    return SearchContentState(
      refrigeratorItemList: refrigeratorItemList ?? this.refrigeratorItemList,
    );
  }
}
