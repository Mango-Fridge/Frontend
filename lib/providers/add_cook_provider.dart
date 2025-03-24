import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/state/add_cook_state.dart';

class AddCookNotifier extends Notifier<AddCookState> {
  @override
  AddCookState build() => AddCookState();

  void resetState() {
    state = AddCookState();
  }

  // 요리 추가
  void addCook(String name, String text) {
    return;
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

  // ToDo: item list에 집어넣는 함수
  void addItem() {}

  // ToDo: item list 열량 합계 함수
  void sumKcal() {}

  // ToDo: item list 탄수화물 합계 함수
  void sumCarb() {}

  // ToDo: item list 단백질 합계 함수
  void sumProtein() {}

  // ToDo: item list 지방 합계 함수
  void sumFat() {}
}

final NotifierProvider<AddCookNotifier, AddCookState> addCookProvider =
    NotifierProvider<AddCookNotifier, AddCookState>(AddCookNotifier.new);
