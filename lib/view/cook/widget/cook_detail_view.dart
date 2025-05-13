import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/providers/cook_detail_provider.dart';
import 'package:mango/providers/cook_provider.dart';
import 'package:mango/providers/refrigerator_provider.dart';
import 'package:mango/state/add_cook_state.dart';
import 'package:mango/state/refrigerator_state.dart';
import 'package:mango/toastMessage.dart';

class CookDetailView extends ConsumerStatefulWidget {
  final Cook? cook;
  const CookDetailView({super.key, required this.cook});

  @override
  ConsumerState<CookDetailView> createState() => _CookDetailViewState();
}

class _CookDetailViewState extends ConsumerState<CookDetailView> {
  CookDetailNotifier? get cookDetailNotifier =>
      ref.watch(cookDetailProvider.notifier);
  AddCookState? get _cookState => ref.watch(cookDetailProvider);
  RefrigeratorState? get _refrigeratorState => ref.watch(refrigeratorNotifier);

  @override
  void initState() {
    super.initState();
    // view init 후 데이터 처리를 하기 위함
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await cookDetailNotifier?.getCookDetail(widget.cook?.cookId ?? 0);
      await cookDetailNotifier?.getCookDetailList(widget.cook?.cookId ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);
    bool isCookMemo =
        _cookState?.cookDetail?.cookMemo != null &&
        _cookState!.cookDetail!.cookMemo!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _cookState?.cookDetail?.cookName ?? '음식 명 없음',
          style: const TextStyle(fontSize: 30),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: <Widget>[
              // kcal
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "영양성분표",
                    style: TextStyle(
                      color: const Color.fromRGBO(195, 142, 1, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      '${_cookState?.cookDetail?.cookNutriKcal} kcal',
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                ],
              ),

              // 영양성분
              Row(
                children: <Widget>[
                  nutrientLabel(
                    nutriLabel: '탄',
                    nutriCapacity:
                        '${_cookState?.cookDetail?.cookNutriCarbohydrate}g',
                  ),
                  nutrientLabel(
                    nutriLabel: '단',
                    nutriCapacity:
                        '${_cookState?.cookDetail?.cookNutriProtein}g',
                  ),
                  nutrientLabel(
                    nutriLabel: '지',
                    nutriCapacity: '${_cookState?.cookDetail?.cookNutriFat}g',
                  ),
                ],
              ),

              // 재료: 충분히 재료가 있는지, 개수가 부족한지, 재료가 없는지
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "재료",
                    style: TextStyle(
                      color: Color.fromRGBO(195, 142, 1, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("   •  중분류명과 동일한 물품이 냉장고에 포함되는지 체크합니다."),
                        const Row(
                          children: [
                            Text("   •  수량에 따른 색 변화가 존재합니다. ("),
                            Text(
                              "일치",
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(" / "),
                            Text(
                              "부족",
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(" ) "),
                          ],
                        ),
                        const Text("   •  해당 물품에 중분류명이 없다면 별도의 체크가 되지 않습니다."),
                      ],
                    ),
                  ),
                ],
              ),

              // 중분류, 개수로 재료 체크
              ...?_cookState?.cookDetail?.cookItems?.map((CookItems item) {
                final String? subCategory = item.subCategory;
                final Content? isFridge =
                    _refrigeratorState?.contentList
                        ?.where((content) => content.subCategory == subCategory)
                        .cast<Content?>()
                        .firstOrNull;

                Icon icon;
                if (isFridge == null) {
                  icon = const Icon(Icons.close, color: Colors.red);
                } else if ((isFridge.count ?? 0) >= (item.count ?? 0)) {
                  icon = const Icon(Icons.check, color: Colors.green);
                } else {
                  icon = const Icon(Icons.check, color: Colors.orange);
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              icon,
                              Text(
                                item.itemName ?? '재료 이름 없음',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text('($subCategory)'), // 중분류 표시
                        ],
                      ),
                      const Spacer(),
                      Text(
                        '${item.count ?? 0}개 / ',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${item.nutriKcal ?? 0} kcal',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              // Memo box
              isCookMemo
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "메모",
                        style: TextStyle(
                          color: Color.fromRGBO(195, 142, 1, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        width: design.screenWidth * 0.95,
                        padding: EdgeInsets.all(design.marginAndPadding),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 244, 216, 1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color.fromRGBO(
                              195,
                              142,
                              1,
                              1,
                            ), // 원하는 테두리 색상
                            width: 1.0, // 테두리 두께
                          ),
                        ),
                        child: Text(
                          '${_cookState?.cookDetail?.cookMemo}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )
                  : const SizedBox.shrink(),

              // 요리 삭제 버튼
              Center(
                child: TextButton(
                  onPressed: () async {
                    // AlertDialog를 표시해 사용자 확인을 받음
                    bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('요리 삭제'),
                          content: Text(
                            '${_cookState?.cookDetail?.cookName}을(를) 삭제하시겠습니까?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(false), // 취소
                              child: const Text('취소'),
                            ),
                            TextButton(
                              onPressed: () => context.pop(true), // 확인
                              child: const Text(
                                '삭제',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    // 사용자가 '삭제' 버튼을 눌렀을 때만 삭제 동작 실행
                    if (confirm == true) {
                      if (await ref
                          .read(cookProvider.notifier)
                          .deleteCook(_cookState?.cookDetail?.cookId ?? 0)) {
                        // 삭제 성공
                        FToast().removeCustomToast();
                        toastMessage(
                          context,
                          "${_cookState?.cookDetail?.cookName}이(가) 삭제되었습니다.",
                        );
                        context.pop();
                      } else {
                        // 삭제 실패
                        FToast().removeCustomToast();
                        toastMessage(
                          context,
                          "${_cookState?.cookDetail?.cookName}를 삭제하지 못했습니다.",
                        );
                      }
                    }
                  },
                  child: const Text(
                    "요리 삭제",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 탄단지 라벨
  Widget nutrientLabel({
    required String nutriLabel,
    required String nutriCapacity,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 35,
          height: 35,
          decoration: const BoxDecoration(
            color: Colors.amber, // 노란색 배경
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(nutriLabel, style: const TextStyle(fontSize: 20)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(nutriCapacity, style: const TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}
