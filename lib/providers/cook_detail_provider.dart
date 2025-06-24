import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/services/cook_repository.dart';
import 'package:mango/state/add_cook_state.dart';
import 'package:mango/state/refrigerator_state.dart';

class CookDetailNotifier extends Notifier<AddCookState> {
  final CookRepository _cookRepository = CookRepository();
  final AddCookState _addCookState = AddCookState();

  @override
  AddCookState build() => AddCookState();

  // 요리 상세정보(칼로리, 탄단지 등) 함수
  Future<void> getCookDetail(int cookId) async {
    try {
      final Cook cookDetail = await _cookRepository.getCookDetail(cookId);
      _addCookState.cookDetail = cookDetail;

      state = state.copyWith(cookDetail: cookDetail);
    } catch (e) {
      AppLogger.logger.e('[cook_provider/getCookDetail]: $e');
    }
  }

  // 요리 상세정보 리스트(개수, 중분류 등)
  Future<void> getCookDetailList(int cookId) async {
    try {
      final Cook listDetail = await _cookRepository.getCookDetailList(cookId);

      // 기존 유지
      final Cook? current = state.cookDetail;

      final Cook cookDetail = listDetail.copyWith(
        cookId: current?.cookId,
        cookName: current?.cookName,
        cookMemo: current?.cookMemo,
        cookNutriKcal: current?.cookNutriKcal,
        cookNutriCarbohydrate: current?.cookNutriCarbohydrate,
        cookNutriProtein: current?.cookNutriProtein,
        cookNutriFat: current?.cookNutriFat,
      );

      state = state.copyWith(cookDetail: cookDetail);
    } catch (e) {
      AppLogger.logger.e('[cook_provider/getCookDetailList]: $e');
    }
  }

  // 중분류를 통해 냉장고에 일치하는 항목이 있을 경우, 해당 냉장고 재료 반환
  List<Content> refrigeratorSubCategory(
    AddCookState cookState,
    RefrigeratorState? refrigeratorState,
  ) {
    final List<CookItems>? cookItems = cookState.cookDetail?.cookItems;
    final List<Content>? fridgeItems = refrigeratorState?.contentList;

    if (cookItems == null || fridgeItems == null) return [];

    // 요리 재료에 있는 subCategory
    final Set<String> cookSubCategories =
        cookItems
            .map(
              (CookItems item) => item.subCategory,
            ) // cookItems 리스트의 각 CookItems 객체에서 subCategory 값만 가져옴
            .whereType<String>() // null이 아닌 String 타입만
            .toSet(); // 중복 제거 -> Set<String> 형태로

    // 냉장고 항목 중 subCategory가 요리 재료의 것과 일치하는 Content만 반환
    return fridgeItems
        .where(
          (Content content) =>
              content.subCategory != null &&
              cookSubCategories.contains(content.subCategory),
        ) // 리스트에서 조건에 만족하는 것만
        .toList(); // 조건 만족하면 해당 타입으로 반환(여기서는 List<Content>)
  }

  // 중분류를 통해 냉장고에 일치하는 항목이 없을 경우, 요리 해당 재료(중분류) 반환
  List<String> cookItemSubCategory(
    AddCookState cookState,
    RefrigeratorState? refrigeratorState,
  ) {
    final List<CookItems>? cookItems = cookState.cookDetail?.cookItems;
    final List<Content>? fridgeItems = refrigeratorState?.contentList;

    if (cookItems == null || fridgeItems == null) return [];

    // 냉장고에 있는 subCategory
    final Set<String> fridgeSubCategories =
        fridgeItems
            .map((Content content) => content.subCategory)
            .whereType<String>()
            .toSet();

    // 냉장고에 없는 요리 재료들의 subCategory만 추출
    return cookItems
        .map((CookItems item) => item.subCategory)
        .whereType<String>()
        .where(
          (String subCategory) => !fridgeSubCategories.contains(subCategory),
        )
        .toSet()
        .toList();
  }
}

final NotifierProvider<CookDetailNotifier, AddCookState> cookDetailProvider =
    NotifierProvider<CookDetailNotifier, AddCookState>(CookDetailNotifier.new);
