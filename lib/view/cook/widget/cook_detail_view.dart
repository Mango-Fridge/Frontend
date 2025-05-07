import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/providers/cook_detail_provider.dart';
import 'package:mango/providers/refrigerator_provider.dart';
import 'package:mango/state/add_cook_state.dart';
import 'package:mango/state/refrigerator_state.dart';

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: <Widget>[
              // Memo box
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '메모: ${_cookState?.cookDetail?.cookMemo}',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),

              // kcal box
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '${_cookState?.cookDetail?.cookNutriKcal}kcal',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // 영양성분 box
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          nutriCapacity:
                              '${_cookState?.cookDetail?.cookNutriFat}g',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...?_cookState?.cookDetail?.cookItems?.map((
                      CookItems item,
                    ) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.itemName ?? '재료 이름 없음',
                                  // '${content.itemName ?? '재료 이름 없음'}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text('(${item.category})'), // 중분류 후에 디자인 할 것
                              ],
                            ),
                            const Spacer(),
                            Text(
                              '${item.count ?? 0}개 / ',
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${item.nutriKcal ?? 0} kcal',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("일치하는 물품", style: TextStyle(fontSize: 30)),
                          ...cookDetailNotifier!
                              .refrigeratorSubCategory(
                                _cookState!,
                                _refrigeratorState,
                              )
                              .map(
                                (Content content) => Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        content.contentName,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${content.count}개 / ${content.nutriKcal} kcal",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("필요한 물품", style: TextStyle(fontSize: 30)),
                          ...cookDetailNotifier!
                              .cookItemSubCategory(
                                _cookState!,
                                _refrigeratorState,
                              )
                              .map(
                                (String itemSubCategory) => Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        itemSubCategory,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
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

  // 탄단지 라벨
  Widget nutrientLabel({
    required String nutriLabel,
    required String nutriCapacity,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Colors.amber, // 노란색 배경
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              nutriLabel,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Text(nutriCapacity, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}