import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/state/add_cook_state.dart';
import 'package:mango/model/content.dart';

class CookDetailNotifier extends Notifier<AddCookState> {
  @override
  AddCookState build() => AddCookState();

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

final NotifierProvider<CookDetailNotifier, AddCookState> CookDetailProvider =
    NotifierProvider<CookDetailNotifier, AddCookState>(CookDetailNotifier.new);
