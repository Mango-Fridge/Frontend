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
      sampleContentList.toList(),
      widget.cook!.cookingItems.toList(),
    );

    final missingIngredients = getMissingCookIngredients(
      widget.cook!.cookingItems,
      sampleContentList,
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.amber[100], // 노란색 배경
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Text(
                            cookingItem.category ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Text(
                        "${cookingItem.count} 개 / ${cookingItem.nutriKcal}kcal",
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.amber[100], // 노란색 배경
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Text(
                            item.category ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Text(
                        "${item.count} 개 / ${item.nutriKcal}kcal",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }),

              // 필요한 물품 알려주는 하단 박스
              // 냉장고에 재료가 부족할 경우 해당 박스 표시
              missingIngredients.isNotEmpty
                  ? Container(
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
                              "${getMissingCookIngredients(widget.cook!.cookingItems, sampleContentList).join(', ')} 입니다.",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  : Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.green[100], // 배경색 변경 (선택 사항)
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        "현재 냉장고 재료로 ${widget.cook?.cookingName}을(를) 만들 수 있습니다!",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
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

  // 냉장고에 존재하지 않는 요리 재료 표시 함수
  List<String> getMissingCookIngredients(
    List<Content> cookIngredients,
    List<Content> refrigerIngredients,
  ) {
    // refrigerIngredients에서 카테고리 리스트 추출
    final refrigerCategories =
        refrigerIngredients
            .map((item) => item.category)
            .where((category) => category != null)
            .toSet(); // 중복 제거

    // cookIngredients에서 refrigerCategories에 없는 항목 필터링
    return cookIngredients
        .where(
          (item) =>
              item.category != null &&
              !refrigerCategories.contains(item.category),
        )
        .map((item) => item.contentName)
        .toList();
  }

  // 일치하는 물품 반환하는 함수
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
