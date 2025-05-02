import 'package:mango/model/refrigerator_item.dart';

class SearchItemState {
  List<RefrigeratorItem>? refrigeratorItemList;
  int? page;
  bool? isLoading;
  bool? isLoadingMore;
  bool? hasMore;
  bool? isSearching;

  SearchItemState({
    this.refrigeratorItemList,
    this.page = 0,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.isSearching = false,
  });

  SearchItemState copyWith({
    List<RefrigeratorItem>? refrigeratorItemList,
    int? page,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    bool? isSearching,
  }) {
    return SearchItemState(
      refrigeratorItemList: refrigeratorItemList ?? this.refrigeratorItemList,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
