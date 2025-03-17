import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/providers/generate_cook_provider.dart';
import 'package:mango/view/cook/sub_widget/app_bar_widget.dart';
import 'package:mango/view/cook/sub_widget/bottom_sheet_widget.dart';

class GenerateCookView extends ConsumerStatefulWidget {
  const GenerateCookView({super.key});

  @override
  ConsumerState<GenerateCookView> createState() => _GenerateCookViewState();
}

class _GenerateCookViewState extends ConsumerState<GenerateCookView> {
  // 텍스트 필드 입력을 관리하기 위한 컨트롤러
  final TextEditingController _cookNameController = TextEditingController();
  final TextEditingController _searchIngridientController =
      TextEditingController();
  final TextEditingController _memoController = TextEditingController();

  // 포커스 노드: 텍스트 필드의 포커스 상태 관리 -> 키보드 상태 관리 목적
  final FocusNode _cookNameFocusNode = FocusNode();
  final FocusNode _searchIngredientFocusNode = FocusNode();

  @override
  // 상태 초기화 - 포커스 상태 변경 리스너 상태 초기화
  void initState() {
    super.initState();
    _cookNameFocusNode.addListener(() {
      ref.read(isCookNameFocused.notifier).state = _cookNameFocusNode.hasFocus;
    });

    _searchIngredientFocusNode.addListener(() {
      ref.read(isSearchIngredientFocused.notifier).state =
          _searchIngredientFocusNode.hasFocus;
      ref.read(isSearchFieldEmpty.notifier).state =
          _searchIngridientController.text.isEmpty;
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
          title: AppBarWidget(
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // 검색 필드
                TextField(
                  controller: _searchIngridientController,
                  focusNode: _searchIngredientFocusNode,
                  decoration: InputDecoration(
                    hintText: '냉장고에 있는 음식 재료를 추가해보세요',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        ref.watch(isSearchFieldEmpty)
                            ? Icons.search
                            : Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (!ref.watch(isSearchFieldEmpty)) {
                          _searchIngridientController.clear();
                          ref.read(isSearchFieldEmpty.notifier).state = true;
                        }
                      },
                    ),
                  ),
                  onChanged: (String value) {
                    // 입력값이 변경될 때 상태 업데이트
                    ref.read(isSearchFieldEmpty.notifier).state = value.isEmpty;
                  },
                ),
                SizedBox(height: design.screenHeight * 0.3),
                const Text("재료를 추가해주세요."),
              ],
            ),
          ),
        ),

        // 바텀 시트 - 키보드 등장 시 숨김 관리 위해 visibility 위젯 사용
        bottomSheet: Visibility(
          visible:
              !ref.watch(isSearchIngredientFocused) &&
              !ref.watch(isSearchIngredientFocused),
          child: Container(
            color: Colors.amber,
            padding: const EdgeInsets.all(16.0),
            child: BottomSheetWidget(
              memoController: _memoController,
              onAddPressed: () {
                final String cookName = _cookNameController.text;
                final String ingredients = _searchIngridientController.text;
                context.pop(context);
                ref
                    .read(generateCookProvider.notifier)
                    .recipeSave(cookName, ingredients);
              },
            ),
          ),
        ),
      ),
    );
  }
}
