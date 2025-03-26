import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/services/sample_content_repository.dart';

class CookDetailView extends ConsumerStatefulWidget {
  final Cook? cook;
  const CookDetailView({super.key, required this.cook});
  @override
  ConsumerState<CookDetailView> createState() => _CookDetailViewState();
}

class _CookDetailViewState extends ConsumerState<CookDetailView> {
  @override
  Widget build(BuildContext context) {
    final filteredItems = filterContentsByCategory(
      widget.cook!.cookingItems.toList(),
      sampleContentList.toList(),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(widget.cook?.cookingName ?? '음식 명 없음'),
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
                      widget.cook?.cookingMemo ?? '',
                      style: const TextStyle(fontSize: 14),
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
                      '${widget.cook?.cookingNutriKcal}kcal',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    nutrientLabel(
                      nutriLabel: '탄',
                      nutriCapacity:
                          '${widget.cook?.cookingNutriCarbohydrate}g',
                    ),
                    nutrientLabel(
                      nutriLabel: '단',
                      nutriCapacity: '${widget.cook?.cookingNutriProtein}g',
                    ),
                    nutrientLabel(
                      nutriLabel: '지',
                      nutriCapacity: '${widget.cook?.cookingNutriFat}g',
                    ),
                  ],
                ),
              ),

              // 레시피 재료 list
              const Text(
                "요리 재료",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...widget.cook!.cookingItems.map((Content cookingItem) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cookingItem.contentName,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Text(
                        "4개 / 245 kcal",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }),

              // 일치하는 물품 list
              const Text(
                "일치하는 물품",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...filteredItems.map((Content item) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        item.contentName,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Text(
                        "12개 / 3,000 kcal",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }),

              // 필요한 물품 알려주는 하단 박스
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "해당 음식을 만들기 위해 필요한 재료는",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          getMissingCookIngredients(
                            widget.cook!.cookingItems
                                .map((item) => item.contentName)
                                .toList(),
                            sampleContentList
                                .map((item) => item.contentName)
                                .toList(),
                          ).join(', '),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('입니다.', style: TextStyle(fontSize: 14)),
                      ],
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

  Iterable<String> getMissingCookIngredients(
    List<String> cookIngredientNames,
    List<String> refrigerIngredientNames,
  ) {
    return cookIngredientNames.where(
      (name) => !refrigerIngredientNames.contains(name),
    );
  }

  List<Content> filterContentsByCategory(
    List<Content> RefrigeratorList,
    List<Content> CookingList,
  ) {
    // CookingList의 category 값을 Set으로 변환 (중복 제거)
    final categorySet = CookingList.map((content) => content.category).toSet();

    // RefrigeratorList에서 category 값이 두 번째 리스트에 포함된 항목만 필터링
    return RefrigeratorList.where(
      (content) => categorySet.contains(content.category),
    ).toList();
  }
}
