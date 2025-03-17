import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/providers/generate_cook_provider.dart';
import 'cook_view.dart';

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

  // 요리 나가기 알럿창 표시
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
    final cookState = ref.watch(generateCookProvider); // 상태 감시
    final cookNotifier = ref.read(generateCookProvider.notifier); // 싱태 변경

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 포커스 상태에 따른 사이즈 변화 시 애니메이션을 위함
              AnimatedContainer(
                onEnd: () {
                  ref.read(isOpenCookName.notifier).state =
                      !ref.read(isOpenCookName);
                },
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                width:
                    ref.watch(isCookNameFocused)
                        ? design.screenWidth * 0.75
                        : design.screenWidth * 0.44,
                child:
                    ref.watch(isCookNameFocused)
                        ? TextField(
                          // controller와 focusnode 를 텍스트필드에 연결
                          controller: _cookNameController,
                          focusNode: _cookNameFocusNode,
                          decoration: InputDecoration(
                            hintText: '요리 이름 입력',
                            suffixIcon: const Icon(Icons.edit, size: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0,
                            ),
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 16),
                        )
                        // focusing되지 않을 때는 text로 표시
                        : GestureDetector(
                          onTap: () {
                            _cookNameFocusNode.requestFocus();
                            ref.read(isCookNameFocused.notifier).state = true;
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    _cookNameController.text.isEmpty
                                        ? '요리 이름 입력'
                                        : _cookNameController.text,
                                    overflow:
                                        TextOverflow
                                            .ellipsis, // 텍스트가 box의 가로 길이를 넘어가면 ... 표시
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                      color:
                                          _cookNameController.text.isEmpty
                                              ? Colors.grey
                                              : Colors.black,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                const Icon(Icons.edit, size: 20),
                              ],
                            ),
                          ),
                        ),
              ),
              SizedBox(width: design.marginAndPadding),

              // 영양성분 표시 box
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                width:
                    ref.watch(isCookNameFocused)
                        ? design.screenWidth * 0
                        : design.screenWidth * 0.31,

                child:
                    !ref.watch(isCookNameFocused) && !ref.watch(isOpenCookName)
                        ? Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Wrap(
                            spacing: 15.0,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text('열량', style: TextStyle(fontSize: 12)),
                                  Text('300', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text('탄', style: TextStyle(fontSize: 12)),
                                  Text('50', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text('단', style: TextStyle(fontSize: 12)),
                                  Text('20', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text('지', style: TextStyle(fontSize: 12)),
                                  Text('10', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        )
                        // 요리 이름 작성란에 포커싱이 되면 비우기
                        : Container(),
              ),
            ],
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // 메모 입력란
                TextField(
                  controller: _memoController,
                  decoration: InputDecoration(
                    hintText: '요리에 대한 메모를 입력해보세요',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon:
                        _memoController.text.isNotEmpty
                            ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _memoController.clear();
                                });
                              },
                              icon: const Icon(Icons.clear),
                            )
                            : null,
                  ),
                  maxLength: 90,
                  minLines: 1,
                  maxLines: 3, // 최대 3줄까지 높이 늘어남, 이후 스크롤
                  keyboardType: TextInputType.multiline, // 여러 줄 입력 가능
                  textInputAction: TextInputAction.newline, // 엔터 키로 줄바꿈
                  onChanged: (String value) {
                    setState(() {}); // 화면 업데이트.
                  },
                ),
                SizedBox(height: design.marginAndPadding),

                // 추가하기 버튼
                ElevatedButton(
                  onPressed: () {
                    // 입력값 가져오기
                    final String cookName = _cookNameController.text;
                    final String ingredients = _searchIngridientController.text;

                    context.pop(context); // cook view로 돌아감

                    // 요리 저장 - GenerateCookNotifier의 recipeSave 호출
                    cookNotifier.recipeSave(cookName, ingredients);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text(
                    '추가하기',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: design.marginAndPadding * 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//  generateCookProvider(cookName, ingredients);
