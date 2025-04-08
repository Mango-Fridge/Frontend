import 'package:mango/model/refrigerator_item.dart';

class SearchItemState {
  List<RefrigeratorItem>? refrigeratorItemList;
  int? page;
  bool? isLoading;
  bool? hasMore;

  SearchItemState({
    this.refrigeratorItemList,
    this.page = 0,
    this.isLoading = false,
    this.hasMore = true,
  });

  SearchItemState copyWith({
    List<RefrigeratorItem>? refrigeratorItemList,
    int? page,
    bool? isLoading,
    bool? hasMore,
  }) {
    return SearchItemState(
      refrigeratorItemList: refrigeratorItemList ?? this.refrigeratorItemList,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
