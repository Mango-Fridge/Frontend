import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/services/cook_repository.dart';
import 'package:mango/state/add_cook_state.dart';
import 'package:mango/model/content.dart';
import 'package:mango/services/content_repository.dart';

class CookDetailNotifier extends Notifier<AddCookState> {
  final ContentRepository _contentRepository = ContentRepository();
  final CookRepository _cookRepository = CookRepository();
  final AddCookState _addCookState = AddCookState();

  @override
  AddCookState build() => AddCookState();

  // cookItemId로 Content를 조회하는 함수
  Future<Content?> _getContentByCookItemId(int cookItemId) async {
    return await _contentRepository.loadContent(cookItemId);
  }

  // 냉장고에 존재하지 않는 요리 재료 표시 함수
  Future<List<String>> getMissingCookIngredients(
    List<CookItems> cookIngredients,
    List<Content> refrigerIngredients,
  ) async {
    // refrigerIngredients에서 sub 카테고리 리스트 추출
    final refrigerSubCategories =
        refrigerIngredients
            .map((item) => item.subCategory)
            .where((subCategory) => subCategory != null)
            .toSet(); // 중복 제거

    // cookIngredients에서 refrigerCategories에 없는 항목 필터링
    List<String> missingIngredients = [];
    for (var item in cookIngredients) {
      final content = await _getContentByCookItemId(item.cookItemId ?? 0);
      if (content != null &&
          content.subCategory != null &&
          !refrigerSubCategories.contains(content.subCategory)) {
        missingIngredients.add(item.cookItemName ?? "");
      }
    }
    return missingIngredients;
  }

  // 일치하는 물품 반환하는 함수
  Future<List<Content>> filterContentsBySubCategory(
    List<Content> RefrigeratorList,
    List<CookItems> cookItems,
  ) async {
    // cookItems의 subCategory 값을 Set으로 변환 (중복 제거)
    final subCategorySet = <String?>{};
    for (var item in cookItems) {
      final content = await _getContentByCookItemId(item.cookItemId ?? 0);
      if (content?.subCategory != null) {
        subCategorySet.add(content!.subCategory);
      }
    }

    // RefrigeratorList에서 subCategory 값이 두 번째 리스트에 포함된 항목만 필터링
    return RefrigeratorList.where(
      (content) => subCategorySet.contains(content.subCategory),
    ).toList();
  }

  // 요리 상제정보 함수
  Future<void> getCookDetail(int cookId) async {
  try {
    final Cook cookDetail = await _cookRepository.getCookDetail(cookId);
    _addCookState.cookDetail = cookDetail;

    state = state.copyWith(cookDetail: cookDetail);
  } catch (e) {
    AppLogger.logger.e('[cook_provider/getCookDetail]: $e');
  }
}
}

final NotifierProvider<CookDetailNotifier, AddCookState> cookDetailProvider =
    NotifierProvider<CookDetailNotifier, AddCookState>(CookDetailNotifier.new);
