import 'package:mango/model/refrigerator_item.dart';

class AddCookState {
  List<RefrigeratorItem>? itemListForCook;

  int? totalKcal;
  int? totalCarb;
  int? totalProtein;
  int? totalFat;

  bool? isCookNameFocused;
  bool? isSearchIngredientFocused;
  bool? isOpenCookName;
  bool? isSearchFieldEmpty;

  AddCookState({
    this.itemListForCook,

    this.totalKcal,
    this.totalCarb,
    this.totalProtein,
    this.totalFat,

    this.isCookNameFocused,
    this.isSearchIngredientFocused,
    this.isOpenCookName,
    this.isSearchFieldEmpty,
  });

  AddCookState copyWith({
    List<RefrigeratorItem>? itemListForCook,

    int? totalKcal,
    int? totalCarb,
    int? totalProtein,
    int? totalFat,

    bool? isCookNameFocused,
    bool? isSearchIngredientFocused,
    bool? isOpenCookName,
    bool? isSearchFieldEmpty,
  }) {
    return AddCookState(
      itemListForCook: itemListForCook,

      totalKcal: this.totalKcal,
      totalCarb: this.totalCarb,
      totalProtein: this.totalProtein,
      totalFat: this.totalFat,

      isSearchIngredientFocused:
          isSearchIngredientFocused ?? this.isSearchIngredientFocused,
      isSearchFieldEmpty: isSearchFieldEmpty ?? this.isSearchFieldEmpty,
      isOpenCookName: isOpenCookName ?? isOpenCookName,
      isCookNameFocused: isCookNameFocused ?? isCookNameFocused,
    );
  }
}
