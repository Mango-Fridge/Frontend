import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/refrigerator_item.dart';

class AddCookState {
  List<RefrigeratorItem>? itemListForCook;
  bool? isCookNameFocused;
  bool? isSearchIngredientFocused;
  bool? isOpenCookName;
  bool? isSearchFieldEmpty;

  AddCookState({
    this.itemListForCook,
    this.isCookNameFocused,
    this.isSearchIngredientFocused,
    this.isOpenCookName,
    this.isSearchFieldEmpty,
  });

  AddCookState copyWith({
    List<RefrigeratorItem>? itemListForCook,
    bool? isCookNameFocused,
    bool? isSearchIngredientFocused,
    bool? isOpenCookName,
    bool? isSearchFieldEmpty,
  }) {
    return AddCookState(
      itemListForCook: itemListForCook,
      isCookNameFocused: isCookNameFocused,
      isSearchFieldEmpty: isSearchIngredientFocused,
      isOpenCookName: isOpenCookName,
      isSearchIngredientFocused: isSearchFieldEmpty,
    );
  }
}

class AddCookNotifier extends Notifier<AddCookState> {
  @override
  AddCookState build() => AddCookState();

  void resetState() {
    state = AddCookState();
  }

  // 요리 추가
  void addItem(String name, String text) {
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
}

final NotifierProvider<AddCookNotifier, AddCookState> addCookProvider =
    NotifierProvider<AddCookNotifier, AddCookState>(AddCookNotifier.new);
