import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/services/cook_repository.dart';
import 'package:mango/state/cook_state.dart';
import 'package:mango/model/cook.dart';

class CookNotifier extends Notifier<CookState?> {
  final CookRepository _cookRepository = CookRepository();
  CookState _cookState = CookState();

  @override
  CookState? build() => CookState();

  // 초기화 함수
  void resetState() {
    _cookState = CookState();
    state = _cookState;
  }

  // Cook 저장 함수
  Future<bool> addCook(
    String cookName,
    String cookMemo,
    int cookNutriKcal,
    int cookNutriCarbohydrate,
    int cookNutriFat,
    int cookNutriProtein,
    int groupId,
    List<CookItems> cookItems,
  ) async {
    try {
      Cook newCook = Cook(
        cookName: cookName,
        cookMemo: cookMemo,
        cookNutriKcal: cookNutriKcal,
        cookNutriCarbohydrate: cookNutriCarbohydrate,
        cookNutriFat: cookNutriFat,
        cookNutriProtein: cookNutriProtein,
        groupId: groupId,
        cookItems: cookItems,
      );

      await _cookRepository.addCook(newCook);

      state = state?.copyWith(
        cookList: <Cook>[
          ...(state?.cookList ?? <Cook>[]),
          newCook,
        ], // 새롭게 만든 newCook을 cookList에 추가
      );
      return true;
    } catch (e) {
      AppLogger.logger.e(e);
      return false;
    }
  }

  // Cook list load 함수
  Future<void> loadCookList(int groupId) async {
    try {
      final List<Cook> cookList = await _cookRepository.loadCookList(groupId);
      _cookState.cookList = cookList;

      state = state?.copyWith(cookList: _cookState.cookList);
    } catch (e) {
      AppLogger.logger.e('[cook_provider/loadContentList]: $e');
    }
  }

  // 요리 삭제 함수
  Future<bool> deleteCook(int cookId) async {
    try {
      // 1. 상태를 즉시 업데이트하여 cookList에서 항목 제거
      final updatedCookList =
          state?.cookList?.where((cook) => cook.cookId != cookId).toList();
      state = state?.copyWith(cookList: updatedCookList);

      // 2. 비동기 작업 수행 (서버에서 삭제)
      await _cookRepository.DeleteCook(cookId);
      return true;
    } catch (e) {
      // 에러 처리
      AppLogger.logger.e("[cook_provider/deleteCook]: $e");
      return false;
    }
  }
}

final NotifierProvider<CookNotifier, CookState?> cookProvider =
    NotifierProvider<CookNotifier, CookState?>(CookNotifier.new);
