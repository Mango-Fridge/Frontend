import 'package:mango/model/refrigerator_item.dart';

class SearchItemState {
  List<RefrigeratorItem>? refrigeratorItemList;

  SearchItemState({this.refrigeratorItemList});

  SearchItemState copyWith({List<RefrigeratorItem>? refrigeratorItemList}) {
    return SearchItemState(
      refrigeratorItemList: refrigeratorItemList ?? this.refrigeratorItemList,
    );
  }
}
