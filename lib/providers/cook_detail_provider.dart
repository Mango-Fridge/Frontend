import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/services/cook_repository.dart';
import 'package:mango/state/add_cook_state.dart';

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
}

final NotifierProvider<CookDetailNotifier, AddCookState> cookDetailProvider =
    NotifierProvider<CookDetailNotifier, AddCookState>(CookDetailNotifier.new);
