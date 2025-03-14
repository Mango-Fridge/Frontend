import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/providers/cook_provider.dart';
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

  // 포커스 노드: 텍스트 필드의 포커스 상태 관리 -> 키보드 상태 관리 목적
  final FocusNode _cookNameFocusNode = FocusNode();
  final FocusNode _searchIngredientFocusNode = FocusNode();

  bool _isCookNameFocused = false;
  bool _isSearchIngredientFocused = false;

  // 검색어 입력값을 초기화할 때 사용되는 변수
  bool _isSearchFieldEmpty = true;

  @override
  // 상태 초기화 - 포커스 상태 변경 리스너 상태 초기화
  void initState() {
    super.initState();
    _cookNameFocusNode.addListener(() {
      setState(() {
        _isCookNameFocused = _cookNameFocusNode.hasFocus;
      });
    });

    _searchIngredientFocusNode.addListener(() {
      setState(() {
        _isSearchIngredientFocused = _searchIngredientFocusNode.hasFocus;
        _isSearchFieldEmpty = _searchIngridientController.text.isEmpty;
      });
    });
  }

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 포커스 상태에 따른 사이즈 변화 시 애니메이션을 위함
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                width:
                    _isCookNameFocused
                        ? design.screenWidth * 0.75
                        : design.screenWidth * 0.44,
                child: TextField(
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
                ),
              ),
              SizedBox(width: design.marginAndPadding),

              // 영양성분 표시 box
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                width:
                    _isCookNameFocused
                        ? design.screenWidth * 0
                        : design.screenWidth * 0.31,

                child:
                    !_isCookNameFocused
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
                        _isSearchFieldEmpty ? Icons.search : Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (!_isSearchFieldEmpty) {
                          _searchIngridientController.clear();
                          setState(() {
                            _isSearchFieldEmpty = true;
                          });
                        }
                      },
                    ),
                  ),
                  onChanged: (String value) {
                    // 입력값이 변경될 때 상태 업데이트
                    setState(() {
                      _isSearchFieldEmpty = value.isEmpty;
                    });
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
          visible: !_isSearchIngredientFocused && !_isCookNameFocused,
          child: Container(
            color: Colors.amber,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // 메모 입력란
                const TextField(
                  decoration: InputDecoration(
                    hintText: '요리에 대한 메모를 입력해보세요',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLength: 90,
                  minLines: 1,
                  maxLines: 3, // 최대 3줄까지 높이 늘어남, 이후 스크롤
                  keyboardType: TextInputType.multiline, // 여러 줄 입력 가능
                  textInputAction: TextInputAction.newline, // 엔터 키로 줄바꿈
                ),
                SizedBox(height: design.marginAndPadding),

                // 추가하기 버튼
                ElevatedButton(
                  onPressed: () {
                    // 입력값 가져오기
                    final String cookName = _cookNameController.text;
                    final String ingredients = _searchIngridientController.text;

                    ref.read(recipeNameProvider.notifier).state = cookName;
                    ref.read(ingredientsProvider.notifier).state = ingredients;
                    context.pop(context); // cook view로 돌아감
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
