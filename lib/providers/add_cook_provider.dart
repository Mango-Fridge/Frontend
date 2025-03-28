import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/content.dart';
import 'package:mango/model/cook.dart';
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

  // Cook 저장 함수
  Future<void> addCook(
    int groupID,
    String cookingName,
    String cookingMemo,
    String cookingNutriKcal,
    String cookingNutriCarbohydrate,
    String cookingNutriFat,
    String cookingNutriProtein,
    List<Content> cookingItems,
  ) async {
    try {
      await _cookRepository.addCook(
        Cook(
          groupID: groupID,
          cookingName: cookingName,
          cookingMemo: cookingMemo,
          cookingNutriKcal: cookingNutriKcal,
          cookingNutriCarbohydrate: cookingNutriCarbohydrate,
          cookingNutriFat: cookingNutriFat,
          cookingNutriProtein: cookingNutriProtein,
          cookingItems: cookingItems,
        ),
      );
    } catch (e) {
      // 에러 처리
    }
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

  void addItem(RefrigeratorItem item) {
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
              return cookItem.copyWith(
                count: (cookItem.count ?? 0) + state.itemCount,
              );
            }
            return cookItem;
          }).toList();
    }

    state = state.copyWith(itemListForCook: cookItemList);
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

  void addItemCount() {
    int test = state.itemCount + 1;
    state = state.copyWith(itemCount: test);
  }

  void reduceItemCount() {
    if (state.itemCount > 0) {
      state = state.copyWith(itemCount: state.itemCount - 1);
    }
  }
}

final NotifierProvider<AddCookNotifier, AddCookState> addCookProvider =
    NotifierProvider<AddCookNotifier, AddCookState>(AddCookNotifier.new);
