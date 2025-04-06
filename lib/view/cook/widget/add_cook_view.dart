import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
import 'package:mango/model/cook.dart'; // CookItems를 사용하기 위해 추가

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

  // 포커스 노드: 텍스트 필드의 포커스 상태 관리 -> 키보드 상태 관리 목적
  final FocusNode _cookNameFocusNode = FocusNode();
  final FocusNode _searchIngredientFocusNode = FocusNode();

  SearchItemState? get _searchContentState => ref.watch(searchContentProvider);
  AddCookState? get _addCookState => ref.watch(addCookProvider);
  // group 정보 받아옴
  Group? get _group => ref.watch(groupProvider);

  @override
  // 상태 초기화 - 포커스 상태 변경 리스너 상태 초기화
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addCookProvider.notifier).resetState();
      ref.read(addCookProvider.notifier).sumCarb();
      ref.read(addCookProvider.notifier).sumFat();
      ref.read(addCookProvider.notifier).sumProtein();
      ref.read(addCookProvider.notifier).sumKcal();
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

        // -------------------- 페이지 내용
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus(); // 포커스 해제 및 키보드 내리기
          },
          child: Column(
            children: <Widget>[
              // 검색 필드
              Padding(
                padding: EdgeInsets.all(design.marginAndPadding),
                child: TextField(
                  controller: _searchIngridientController,
                  focusNode: _searchIngredientFocusNode,
                  decoration: InputDecoration(
                    hintText: '요리 재료를 검색해보세요',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _addCookState?.isSearchFieldEmpty ?? false
                            ? Icons.search
                            : Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (!(_addCookState?.isSearchFieldEmpty ?? false)) {
                          _searchIngridientController.clear();
                          ref
                              .read(addCookProvider.notifier)
                              .updateSearchFieldEmpty(true);
                        }
                      },
                    ),
                  ),
                  onChanged: (String value) {
                    // 입력값이 변경될 때 상태 업데이트
                    ref
                        .read(addCookProvider.notifier)
                        .updateSearchFieldEmpty(value.isEmpty);
                    ref
                        .read(searchContentProvider.notifier)
                        .loadItemListByString(value);
                  },
                ),
              ),
              Expanded(
                child:
                    _addCookState?.isSearchIngredientFocused ?? false
                        ? _searchContentState != null &&
                                _searchContentState?.refrigeratorItemList !=
                                    null &&
                                _searchContentState!
                                    .refrigeratorItemList!
                                    .isNotEmpty &&
                                _searchIngridientController.text != ''
                            ? _buildItem(
                              _searchContentState?.refrigeratorItemList!,
                              _itemRow,
                            )
                            : _noItemView()
                        : _buildItem(
                          _addCookState?.itemListForCook,
                          _cookItemRow,
                        ),
              ),
            ],
          ),
        ),

        // 바텀 시트 - 키보드 등장 시 숨김 관리 위해 visibility 위젯 사용
        bottomSheet: Visibility(
          visible: !(_addCookState?.isSearchIngredientFocused ?? false),
          child: AddCookBottomSheetWidget(
            memoController: _memoController,
            onAddPressed: () async {
              final String cookName = _cookNameController.text;
              final String memo = _memoController.text;

              final bool isSuccess = await ref
                  .read(cookProvider.notifier)
                  .addCook(
                    cookName,
                    memo,
                    _addCookState?.totalKcal.toString() ?? '0',
                    _addCookState?.totalCarb.toString() ?? '0',
                    _addCookState?.totalProtein.toString() ?? '0',
                    _addCookState?.totalFat.toString() ?? '0',
                    _group?.groupId ?? 0,
                  );

              if (isSuccess) {
                ref
                    .watch(cookProvider.notifier)
                    .loadCookList(_group?.groupId ?? 0);
                toastMessage(context, "$cookName 추가했습니다.");
                context.pop(context); // 성공적으로 음식 추가 후 화면 닫기
              } else {
                toastMessage(
                  context,
                  '$cookName 추가에 실패했습니다.',
                  type: ToastmessageType.errorType,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    List<RefrigeratorItem>? itemList,
    Function(RefrigeratorItem item) content,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: <Widget>[
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: itemList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final RefrigeratorItem item = itemList![index];
                return _buildItemRow(item, content(item));
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildItemRow(RefrigeratorItem item, Widget content) {
    Design design = Design(context);
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              content: AddCookContentView(item: item),
            );
          },
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
        child: content,
      ),
    );
  }

  Widget _itemRow(RefrigeratorItem item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                item.itemName ?? '',
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
            Text(item.brandName ?? '', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _cookItemRow(RefrigeratorItem item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                item.itemName ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${item.count}개 / ${(item.nutriKcal ?? 0) * (item.count ?? 0)}Kcal",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 검색어에 의한 물품이 없을 시 화면
  Widget _noItemView() {
    Design design = Design(context);

    return Column(
      children: <Widget>[
        SizedBox(height: design.screenHeight * 0.25),
        const Text("요리 재료를 추가해주세요."),
      ],
    );
  }
}
