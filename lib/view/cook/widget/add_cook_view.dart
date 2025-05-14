import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/design.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/add_cook_provider.dart';
import 'package:mango/providers/cook_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/state/add_cook_state.dart';
import 'package:mango/toastMessage.dart';
import 'package:mango/view/cook/modal_view/add_cook_content_view.dart';
import 'package:mango/view/cook/sub_widget/add_cook_app_bar_widget.dart';
import 'package:mango/view/cook/sub_widget/add_cook_bottomSheet_widget.dart';
import 'package:mango/providers/search_item_provider.dart';
import 'package:mango/state/search_item_state.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/view/search_result_view.dart'; // CookItems를 사용하기 위해 추가

class AddCookView extends ConsumerStatefulWidget {
  const AddCookView({super.key});

  @override
  ConsumerState<AddCookView> createState() => _AddCookViewState();
}

class _AddCookViewState extends ConsumerState<AddCookView> {
  // 텍스트 필드 입력을 관리하기 위한 컨트롤러
  final TextEditingController _cookNameController = TextEditingController();
  final TextEditingController _searchIngridientController =
      TextEditingController();
  final TextEditingController _memoController = TextEditingController();

  final ScrollController _listViewScrollController = ScrollController();

  // 포커스 노드: 텍스트 필드의 포커스 상태 관리 -> 키보드 상태 관리 목적
  final FocusNode _cookNameFocusNode = FocusNode();
  final FocusNode _searchIngredientFocusNode = FocusNode();

  SearchItemState? get _searchContentState => ref.watch(searchContentProvider);
  AddCookState? get _addCookState => ref.watch(addCookProvider);
  // group 정보 받아옴
  Group? get _group => ref.watch(groupProvider);
  final TextEditingController _controller = TextEditingController();

  final GlobalKey _memoKey = GlobalKey();

  bool isMemoEmpty = true;
  static const int _memoMaxLine = 15;
  static const int _memoMaxLength = 500;
  final OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black),
    borderRadius: BorderRadius.circular(16.0),
  );

  Timer? _debounce;

  @override
  // 상태 초기화 - 포커스 상태 변경 리스너 상태 초기화
  void initState() {
    super.initState();

    _memoController.addListener(() {
      setState(() {
        isMemoEmpty = _memoController.text.isEmpty;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addCookProvider.notifier).resetState();
      ref.read(addCookProvider.notifier).sumCarb();
      ref.read(addCookProvider.notifier).sumFat();
      ref.read(addCookProvider.notifier).sumProtein();
      ref.read(addCookProvider.notifier).sumKcal();

      ref.watch(searchContentProvider.notifier).resetState();

      bool _isFetchingNextPage = false;

      _listViewScrollController.addListener(() {
        final bool isNearBottom =
            _listViewScrollController.position.pixels >=
            _listViewScrollController.position.maxScrollExtent - 100;

        final bool canLoadMore =
            ref.read(searchContentProvider)?.hasMore ?? false;
        final bool isLoading =
            ref.read(searchContentProvider)?.isLoading ?? false;
        final bool isLoadingMore =
            ref.read(searchContentProvider)?.isLoadingMore ?? false;

        if (isNearBottom && !isLoading && !isLoadingMore && canLoadMore) {
          _isFetchingNextPage = true;

          ref
              .read(searchContentProvider.notifier)
              .loadItemListByString(_searchIngridientController.text)
              .whenComplete(() => _isFetchingNextPage = false);
        }
      });
    });

    _cookNameFocusNode.addListener(() {
      ref
          .read(addCookProvider.notifier)
          .updateCookNameFocused(_cookNameFocusNode.hasFocus);
    });

    _searchIngredientFocusNode.addListener(() {
      ref
          .read(addCookProvider.notifier)
          .updateSearchIngredientFocused(_searchIngredientFocusNode.hasFocus);
      ref
          .read(addCookProvider.notifier)
          .updateSearchFieldEmpty(_searchIngridientController.text.isEmpty);
    });
  }

  // 요리 나가기 알럿창 표시 호출 함수
  void _showExitDialog() {
    showDialog(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text('요리 나가기'),
            content: const Text('해당 페이지를 나가면 요리가 삭제됩니다.\n진행하시겠습니까?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => context.pop(), // "취소" 버튼: 알럿 창 닫기
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  context.pop(); // 알럿 창 닫기
                  if (context.canPop()) {
                    context.pop(); // 이전 화면으로 돌아가기
                  } else {
                    context.go('/cook');
                  }
                },
                child: const Text('확인'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);
    bool isMemoEmpty = _memoController.text.isEmpty;

    return PopScope(
      canPop: false, // 백버튼 작동 금지
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) {
          _showExitDialog(); // 백버튼 눌렀을 때 동작 지정 -> 알럿 창 표시
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: AddCookAppBarWidget(
            cookNameController: _cookNameController,
            cookNameFocusNode: _cookNameFocusNode,
          ),
        ),

        // 탭바
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: design.marginAndPadding,
                ),
                child: const TabBar(
                  indicatorColor: Colors.amber,
                  indicatorWeight: 4.0,
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Design.tabBarSelectedFontSize,
                    fontFamily: 'Mainfonts',
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: Design.tabBarUnSelectedFontSize,
                    fontFamily: 'Mainfonts',
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: <Widget>[Tab(text: '물품'), Tab(text: '메모')],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // 물품 탭의 콘텐츠
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); // 포커스 해제 및 키보드 내리기
                      },
                      child: Column(
                        spacing: 20,
                        children: <Widget>[
                          // 검색 필드
                          Container(
                            margin: EdgeInsets.only(
                              top: design.marginAndPadding,
                              right: design.marginAndPadding,
                              left: design.marginAndPadding,
                            ),
                            padding: EdgeInsets.only(
                              left: design.marginAndPadding,
                              top: design.marginAndPadding * 0.5,
                              bottom: design.marginAndPadding * 0.5,
                            ),
                            decoration: BoxDecoration(
                              color: design.textFieldColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: design.textFieldborderColor,
                              ),
                            ),
                            child: TextField(
                              controller: _searchIngridientController,
                              focusNode: _searchIngredientFocusNode,
                              style: const TextStyle(
                                fontSize: Design.normalFontSize2,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                hintText: "ex) 돼지고기, 소고기",
                                border: InputBorder.none,
                                suffix:
                                    (_searchIngridientController
                                            .text
                                            .isNotEmpty)
                                        ? GestureDetector(
                                          onTap: () {
                                            _searchIngridientController.clear();
                                            _onSearchChanged('');
                                            FocusScope.of(context).unfocus();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              right: design.marginAndPadding,
                                            ),
                                            child: const Icon(
                                              Icons.clear,
                                              color: Colors.red,
                                              size: 18,
                                            ),
                                          ),
                                        )
                                        : null,
                              ),
                              onChanged: (String value) {
                                // 입력값이 변경될 때 상태 업데이트
                                _onSearchChanged(value);
                              },
                            ),
                          ),
                          Expanded(
                            child:
                                _addCookState?.isSearchIngredientFocused ??
                                        false
                                    ? _buildItemList()
                                    : _buildCookItem(
                                      _addCookState?.itemListForCook,
                                      _cookItemRow,
                                    ),
                          ),
                          // 바텀: 열량/탄수화물/단백질/지방, 추가하기 버튼
                          AddCookBottomSheetWidget(
                            onAddPressed: () async {
                              final String cookName = _cookNameController.text;
                              final String memo = _memoController.text;
                              final List<CookItems> cookItems =
                                  (_addCookState?.itemListForCook ?? [])
                                      .map(
                                        (item) => CookItems(
                                          cookItemId: item.itemId ?? 0,
                                          itemName: item.itemName ?? '',
                                          count: item.count ?? 1,
                                          nutriKcal: item.nutriKcal ?? 0,
                                          cookItemName: item.itemName ?? '',
                                          category: item.category ?? '',
                                          brandName: item.brandName ?? '',
                                          storageArea: item.storageArea ?? '',
                                          nutriUnit: item.nutriUnit ?? '',
                                          nutriCapacity:
                                              item.nutriCapacity ?? 0,
                                          subCategory: item.subCategory ?? '',
                                        ),
                                      )
                                      .toList();

                              final bool isSuccess = await ref
                                  .read(cookProvider.notifier)
                                  .addCook(
                                    cookName,
                                    memo,
                                    _addCookState?.totalKcal ?? 0,
                                    _addCookState?.totalCarb ?? 0,
                                    _addCookState?.totalProtein ?? 0,
                                    _addCookState?.totalFat ?? 0,
                                    _group?.groupId ?? 0,
                                    cookItems,
                                  );

                              if (isSuccess) {
                                ref
                                    .watch(cookProvider.notifier)
                                    .loadCookList(_group?.groupId ?? 0);
                                FToast()
                                    .removeCustomToast(); // 띄어졌던 토스트 메시지를 삭제 => 토스트 메시지 중첩 시, 오류 발생
                                toastMessage(context, "$cookName 추가했습니다.");
                                context.pop(context); // 성공적으로 음식 추가 후 화면 닫기
                              } else {
                                FToast().removeCustomToast();
                                toastMessage(
                                  context,
                                  '$cookName 추가에 실패했습니다.',
                                  type: ToastmessageType.errorType,
                                );
                              }
                            },
                            cookName: _cookNameController.text, // 요리 제목 전달
                            itemListForCook:
                                _addCookState?.itemListForCook, // 재료 리스트 전달
                          ),
                        ],
                      ),
                    ),

                    // 메모 탭의 콘텐츠 -> 추후 따로 서브로 빼면 좋을 것같아용
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              // 좌측 상단: 글자수 표시
                              Padding(
                                padding: EdgeInsets.only(
                                  left: design.marginAndPadding,
                                ),
                                child: Text(
                                  '${_memoController.text.length} / $_memoMaxLength',
                                ),
                              ),
                              Spacer(),
                              // 우측 상단: 모두 지우기 버튼
                              TextButton(
                                onPressed:
                                    isMemoEmpty
                                        ? null
                                        : () {
                                          _memoController.clear();
                                        },
                                child: Text(
                                  '모두 지우기',
                                  style: TextStyle(
                                    color:
                                        isMemoEmpty
                                            ? Colors.grey.shade600
                                            : Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // TextField
                          TextField(
                            key: _memoKey,
                            onTap: () => _focusTextField(_memoKey),
                            controller: _memoController,
                            maxLines: _memoMaxLine,
                            maxLength: _memoMaxLength,
                            decoration: InputDecoration(
                              hintText: "최대 500자 까지 작성 가능합니다.",
                              filled: true,
                              fillColor: design.subColor,
                              enabledBorder: textFieldBorder,
                              focusedBorder: textFieldBorder,
                              counterText: "", // 기본 카운터 비활성화
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: design.marginAndPadding,
                            ),
                            child: const Text(
                              '* 요리 상세화면에서 확인이 가능합니다.\n* 메모를 작성하지 않아도 추가 가능합니다.',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemList() {
    return SearchResultView(
      controller: _searchIngridientController,
      searchState: _searchContentState,
      isSearching: ref.watch(searchContentProvider)?.isSearching ?? false,
      scrollController: _listViewScrollController,
      onItemTap: (RefrigeratorItem item) async {
        RefrigeratorItem? loadedItem = await ref
            .read(searchContentProvider.notifier)
            .loadItem(item.itemId ?? 0);

        ref.watch(searchContentProvider.notifier).resetState();
        _controller.text = '';
        FocusManager.instance.primaryFocus?.unfocus(); // 포커스 해제
        _searchIngridientController.text = ''; // 텍스트 초기화
        ref
            .read(addCookProvider.notifier)
            .updateSearchFieldEmpty(true); // 상태 업데이트
        ref
            .watch(addCookProvider.notifier)
            .currentItemCount(
              item.count ?? 1,
            ); // 재료(아이템) 개수(디폴트 1, 수정할 시 개수 그대로 가져옴)

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 255, 246, 218),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(
                  color: Colors.amber, // Yellow border
                  width: 1.0, // Border thickness
                ),
              ),
              content: AddCookContentView(item: loadedItem),
            );
          },
        );
      },
    );
  }

  Widget _buildCookItem(
    List<RefrigeratorItem>? itemList,
    Function(RefrigeratorItem item) content,
  ) {
    final isCookItemRow = content == _cookItemRow;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: itemList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final RefrigeratorItem item = itemList![index];

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (isCookItemRow)
                      Transform.translate(
                        offset: const Offset(8, 0),
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          color: Colors.red,
                          onPressed: () {
                            if (item.itemId != null) {
                              ref
                                  .read(addCookProvider.notifier)
                                  .itemToSub(
                                    item,
                                  ); // 삭제 버튼 눌렀을 때 해당 열량,탄/단/지 총량 제거
                              final updatedList =
                                  itemList
                                      .where((i) => i.itemId != item.itemId)
                                      .toList();
                              ref
                                  .read(addCookProvider.notifier)
                                  .updateItemList(updatedList);
                              toastMessage(
                                context,
                                "${item.itemName}이(가) 삭제되었습니다.",
                              );
                            }
                          },
                        ),
                      ),
                    Expanded(child: content(item)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _cookItemRow(RefrigeratorItem item) {
    Design design = Design(context);

    return Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      (item.itemName ?? '').length > 10
                          ? '${(item.itemName ?? '').substring(0, 10)}...'
                          : item.itemName ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text("${item.brandName}"),
                  ],
                ),
                Flexible(
                  child: Column(
                    children: [
                      Text(
                        '${(item.nutriKcal ?? 0) * (item.count ?? 0)} kcal',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 65, 65, 65),
                        ),
                      ),
                      Text(
                        '${(item.nutriCarbohydrate ?? 0) * (item.count ?? 0)} / '
                        '${(item.nutriProtein ?? 0) * (item.count ?? 0)} / '
                        '${(item.nutriFat ?? 0) * (item.count ?? 0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 65, 65, 65),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${item.count}개',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSearchChanged(String keyword) {
    if (keyword.isEmpty) {
      ref.read(searchContentProvider.notifier).resetState();
      return;
    }

    ref.read(searchContentProvider.notifier).setSearching(true);

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      ref
          .read(addCookProvider.notifier)
          .updateSearchFieldEmpty(keyword.isEmpty);
      await ref
          .read(searchContentProvider.notifier)
          .loadItemListByString(keyword, isRefresh: true);
      ref.read(searchContentProvider.notifier).setSearching(false);
    });
  }

  void _focusTextField(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final BuildContext? context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context, // BuildContext 전달
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.5, // 중앙 설정
        );
      }
    });
  }
}
