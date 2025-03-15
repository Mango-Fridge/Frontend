import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/search_content_provider.dart';
import 'package:mango/state/search_content_state.dart';

class SearchContentView extends ConsumerStatefulWidget {
  const SearchContentView({super.key});
  @override
  ConsumerState<SearchContentView> createState() => _SearchContentViewState();
}

class _SearchContentViewState extends ConsumerState<SearchContentView> {
  SearchContentState? get _searchContentState =>
      ref.watch(searchContentNotifier);

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // view init 후 데이터 처리를 하기 위함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(searchContentNotifier.notifier).resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    Design design = Design(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("물품 추가"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          spacing: 20,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: design.marginAndPadding),
              padding: EdgeInsets.symmetric(
                horizontal: design.marginAndPadding,
              ),
              decoration: BoxDecoration(
                color: Colors.amber[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "ex) 초코칩",
                  border: InputBorder.none,
                ),
                onChanged: (String value) {
                  ref
                      .watch(searchContentNotifier.notifier)
                      .loadItemListByString(value);
                },
              ),
            ),
            Expanded(
              child:
                  _searchContentState != null &&
                          _searchContentState?.refrigeratorItemList != null &&
                          _searchContentState!
                              .refrigeratorItemList!
                              .isNotEmpty &&
                          _controller.text != ''
                      ? _buildItem(_searchContentState?.refrigeratorItemList!)
                      : _noItemView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(List<RefrigeratorItem>? itemList) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          const Divider(),
          ...itemList!.map((RefrigeratorItem item) => _buildItemRow(item)),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildItemRow(RefrigeratorItem item) {
    Design design = Design(context);
    return GestureDetector(
      onTap: () {
        ref.watch(searchContentNotifier.notifier).resetState();
        _controller.text = '';
        context.push(
          '/addContent',
          extra: RefrigeratorItem(
            groupId: item.groupId,
            isOpenItem: item.isOpenItem,
            itemName: item.itemName,
            category: item.category,
            brandName: item.brandName,
            count: item.count,
            regDate: item.regDate,
            expDate: item.expDate,
            storageArea: item.storageArea,
            memo: item.memo,
            nutriUnit: item.nutriUnit,
            nutriCapacity: item.nutriCapacity,
            nutriKcal: item.nutriKcal,
            nutriCarbohydrate: item.nutriCarbohydrate,
            nutriProtein: item.nutriProtein,
            nutriFat: item.nutriFat,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: design.marginAndPadding,
        ),
        padding: EdgeInsets.all(design.marginAndPadding),
        decoration: BoxDecoration(
          color: Colors.amber[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${item.nutriCapacity}${item.nutriUnit} / ${item.nutriKcal}kcal',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(item.brandName, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 검색어에 의한 물품이 없을 시 화면
  Widget _noItemView() {
    Design design = Design(context);

    return Column(
      children: <Widget>[
        const SizedBox(height: 100),
        Image.asset(
          "assets/images/cart.png",
          width: design.cartImageSize,
          height: design.cartImageSize,
        ),
        const Text(
          "찾고 싶은 물품을 검색하거나,\n원하는 물품이 없다면 직접 추가해 보세요!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        ElevatedButton(
          onPressed: () {
            context.push('/addContent');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[300],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("직접 물품 추가"),
        ),
        const Spacer(),
      ],
    );
  }
}
