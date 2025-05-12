import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/state/search_item_state.dart';
import 'package:mango/view/search_item_list_view.dart';
import 'package:shimmer/shimmer.dart';

class SearchResultView extends StatelessWidget {
  final TextEditingController controller;
  final SearchItemState? searchState;
  final bool isSearching;
  final ScrollController? scrollController;
  final void Function(RefrigeratorItem item) onItemTap;

  const SearchResultView({
    super.key,
    required this.controller,
    required this.searchState,
    required this.isSearching,
    required this.scrollController,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<RefrigeratorItem> list =
        searchState?.refrigeratorItemList ?? <RefrigeratorItem>[];

    if (isSearching) {
      return _buildSkeleton();
    }

    if (controller.text.isNotEmpty) {
      if (list.isNotEmpty) {
        return SearchItemListView(
          itemList: list,
          isLoadingMore: searchState?.isLoadingMore ?? false,
          hasMore: searchState?.hasMore ?? false,
          scrollController: scrollController,
          onItemTap: onItemTap,
        );
      } else {
        return _noItemView(context);
      }
    } else {
      return _noSearchView(context);
    }
  }

  Widget _buildSkeleton() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

  // 검색어를 입력하지 않았을 때의 화면
  Widget _noSearchView(BuildContext context) {
    Design design = Design(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: <Widget>[
        Image.asset(
          "assets/images/cart.png",
          width: design.cartImageSize,
          height: design.cartImageSize,
        ),
        const Text(
          "찾고 싶은 물품을 검색하거나,\n원하는 물품이 없다면 직접 추가해 보세요!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Design.normalFontSize1),
        ),
        ElevatedButton(
          onPressed: () {
            context.push('/addContent');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[300],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            "직접 물품 추가",
            style: TextStyle(fontSize: Design.normalFontSize1),
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  // 검색어에 의한 물품이 없을 시 화면
  Widget _noItemView(BuildContext context) {
    Design design = Design(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: <Widget>[
        Image.asset(
          "assets/images/null_item.png",
          width: design.cartImageSize,
          height: design.cartImageSize,
        ),
        const Text(
          "검색어에 해당하는 물품이 없습니다.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Design.normalFontSize1),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
