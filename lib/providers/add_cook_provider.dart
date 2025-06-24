import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/services/cook_repository.dart';
import 'package:mango/state/add_cook_state.dart';

class AddCookNotifier extends Notifier<AddCookState> {
  final CookRepository _cookRepository = CookRepository();

  @override
  AddCookState build() => AddCookState();

  void resetState() {
    state = AddCookState();
  }

  void updateCookNameFocused(bool hasFocus) {
    state = state.copyWith(isCookNameFocused: hasFocus);
  }

  void updateSearchFieldEmpty(bool isEmpty) {
    state = state.copyWith(isSearchFieldEmpty: isEmpty);
  }

  void updateOpenCookName(bool isEmpty) {
    state = state.copyWith(isOpenCookName: isEmpty);
  }

  void updateSearchIngredientFocused(bool hasFocus) {
    state = state.copyWith(isSearchIngredientFocused: hasFocus);
  }

  // cook에 Item을 추가하는 함수 ?
  Future<void> addCookItem(RefrigeratorItem item) async {
    try {
      List<RefrigeratorItem> cookItemList =
          state.itemListForCook ?? <RefrigeratorItem>[];

      bool exists = cookItemList.any(
        (RefrigeratorItem cookItem) => cookItem.itemId == item.itemId,
      );

      if (!exists) {
        cookItemList.add(item.copyWith(count: state.itemCount));
      } else {
        cookItemList =
            cookItemList.map((RefrigeratorItem cookItem) {
              if (cookItem.itemId == item.itemId) {
                return cookItem.copyWith(count: state.itemCount);
              }
              return cookItem;
            }).toList();
      }

      state = state.copyWith(itemListForCook: cookItemList);
    } catch (e) {
      // 에러 처리
      AppLogger.logger.e('[add_cook_provider/addCookItem]: $e');
    }
  }

  // item list 열량 합계 함수
  void sumKcal() {
    int result = 0;

    if (state.itemListForCook != null) {
      result = state.itemListForCook!.fold(
        0,
        (int sum, RefrigeratorItem item) =>
            sum + (item.count ?? 0) * (item.nutriKcal ?? 0),
      );
    }

    state = state.copyWith(totalKcal: result);
  }

  // item list 탄수화물 합계 함수
  void sumCarb() {
    int result = 0;

    if (state.itemListForCook != null) {
      result = state.itemListForCook!.fold(
        0,
        (int sum, RefrigeratorItem item) =>
            sum + (item.count ?? 0) * (item.nutriCarbohydrate ?? 0),
      );
    }

    state = state.copyWith(totalCarb: result);
  }

  // ToDo: item list 단백질 합계 함수
  void sumProtein() {
    int result = 0;

    if (state.itemListForCook != null) {
      result = state.itemListForCook!.fold(
        0,
        (int sum, RefrigeratorItem item) =>
            sum + (item.count ?? 0) * (item.nutriProtein ?? 0),
      );
    }

    state = state.copyWith(totalProtein: result);
  }

  // ToDo: item list 지방 합계 함수
  void sumFat() {
    int result = 0;

    if (state.itemListForCook != null) {
      result = state.itemListForCook!.fold(
        0,
        (int sum, RefrigeratorItem item) =>
            sum + (item.count ?? 0) * (item.nutriFat ?? 0),
      );
    }

    state = state.copyWith(totalFat: result);
  }

  // 추가된 물품에서 삭제 버튼을 클릭했을 때 총량에서 제거
  void itemToSub(RefrigeratorItem item) {
    final int kcalToSub = (item.nutriKcal ?? 0) * (item.count ?? 0);
    final int carbToSub = (item.nutriCarbohydrate ?? 0) * (item.count ?? 0);
    final int proteinToSub = (item.nutriProtein ?? 0) * (item.count ?? 0);
    final int fatToSub = (item.nutriFat ?? 0) * (item.count ?? 0);

    state = state.copyWith(
      totalKcal: state.totalKcal - kcalToSub,
      totalCarb: state.totalCarb - carbToSub,
      totalProtein: state.totalProtein - proteinToSub,
      totalFat: state.totalFat - fatToSub,
    );
  }

  void addItemCount() {
    int test = state.itemCount + 1;
    state = state.copyWith(itemCount: test);
  }

  void reduceItemCount() {
    if (state.itemCount > 1) {
      state = state.copyWith(itemCount: state.itemCount - 1);
    }
  }

  void currentItemCount(int itemCount) {
    state = state.copyWith(itemCount: itemCount);
  }

  // itemListForCook 업데이트 메서드
  void updateItemList(List<RefrigeratorItem> updatedList) {
    state = state!.copyWith(itemListForCook: updatedList);
    // sumCarb();
    // sumFat();
    // sumProtein();
    // sumKcal();
  }
}

final NotifierProvider<AddCookNotifier, AddCookState> addCookProvider =
    NotifierProvider<AddCookNotifier, AddCookState>(AddCookNotifier.new);
