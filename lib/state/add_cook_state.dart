import 'package:mango/model/refrigerator_item.dart';

class AddCookState {
  List<RefrigeratorItem>? itemListForCook;

  int totalKcal;
  int totalCarb;
  int totalProtein;
  int totalFat;

  bool? isCookNameFocused;
  bool? isSearchIngredientFocused;
  bool? isOpenCookName;
  bool? isSearchFieldEmpty;

  int itemCount;

  AddCookState({
    this.itemListForCook,

    this.totalKcal = 0,
    this.totalCarb = 0,
    this.totalProtein = 0,
    this.totalFat = 0,

    this.isCookNameFocused,
    this.isSearchIngredientFocused,
    this.isOpenCookName,
    this.isSearchFieldEmpty,

    this.itemCount = 0,
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

    int? itemCount,
  }) {
    return AddCookState(
      itemListForCook: itemListForCook ?? this.itemListForCook,

      totalKcal: totalKcal ?? this.totalKcal,
      totalCarb: totalCarb ?? this.totalCarb,
      totalProtein: totalProtein ?? this.totalProtein,
      totalFat: totalFat ?? this.totalFat,

      isSearchIngredientFocused:
          isSearchIngredientFocused ?? this.isSearchIngredientFocused,
      isSearchFieldEmpty: isSearchFieldEmpty ?? this.isSearchFieldEmpty,
      isOpenCookName: isOpenCookName ?? isOpenCookName,
      isCookNameFocused: isCookNameFocused ?? isCookNameFocused,

      itemCount: itemCount ?? this.itemCount,
    );
  }
}
