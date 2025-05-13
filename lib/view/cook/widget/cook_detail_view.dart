import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(_cookState?.cookDetail?.cookName ?? '음식 명 없음'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: <Widget>[
              // kcal
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    '영양성분표',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${_cookState?.cookDetail?.cookNutriKcal}kcal',
                    style: const TextStyle(fontSize: 40),
                  ),
                ],
              ),

              // 영양성분
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  nutrientLabel(
                    nutriLabel: '탄',
                    nutriCapacity:
                        '${_cookState?.cookDetail?.cookNutriCarbohydrate}',
                  ),
                  const Spacer(),
                  nutrientLabel(
                    nutriLabel: '단',
                    nutriCapacity:
                        '${_cookState?.cookDetail?.cookNutriProtein}',
                  ),
                  const Spacer(),
                  nutrientLabel(
                    nutriLabel: '지',
                    nutriCapacity: '${_cookState?.cookDetail?.cookNutriFat}',
                  ),
                  const Spacer(),
                ],
              ),

              // 재료: 충분히 재료가 있는지, 개수가 부족한지, 재료가 없는지
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '재료',
                    style: TextStyle(fontSize: 30, color: Colors.orange),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '중분류명과 동일한 물품이 냉장고에 포함되는지 체크합니다.',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          '수량에 따른 색 변화가 존재합니다. (일치 / 부족)',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          '해당 물품에 중분류명이 없다면 별도의 체크가 되지 않습니다.',
                          style: TextStyle(fontSize: 15),
                        ),
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
                } else if (isFridge.subCategory == '미분류') {
                  icon = const Icon(Icons.circle, color: Colors.black, size: 4);
                } else if ((isFridge.count) >= (item.count ?? 0)) {
                  icon = const Icon(Icons.check, color: Colors.green);
                } else {
                  icon = const Icon(Icons.check, color: Colors.orange);
                }

                return Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // '미분류'일 때 패딩
                            subCategory == '미분류'
                                ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: icon,
                                )
                                : icon,
                            Text(
                              item.itemName ?? '재료 이름 없음',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Visibility(
                          // 중분류 표시
                          visible: subCategory != '미분류',
                          child: Text('($subCategory)'),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '${item.count ?? 0}개 / ',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${item.nutriKcal ?? 0} kcal',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                );
              }),
              
              // Memo box
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '메모',
                    style: const TextStyle(fontSize: 30, color: Colors.orange),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: Text(
                      '${_cookState?.cookDetail?.cookMemo}',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ],
              ),
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
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(nutriLabel, style: const TextStyle(fontSize: 25)),
          ),
        ),
        const SizedBox(width: 10),
        Text(nutriCapacity, style: const TextStyle(fontSize: 30)),
      ],
    );
  }
}
