import 'package:mango/model/cook.dart';
import 'package:mango/model/refrigerator_item.dart';

class AddCookState {
  List<RefrigeratorItem>? itemListForCook;
  Cook? cookDetail;

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
    this.cookDetail,

    this.totalKcal = 0,
    this.totalCarb = 0,
    this.totalProtein = 0,
    this.totalFat = 0,

    this.isCookNameFocused,
    this.isSearchIngredientFocused,
    this.isOpenCookName,
    this.isSearchFieldEmpty,

    this.itemCount = 1,
  });

  AddCookState copyWith({
    List<RefrigeratorItem>? itemListForCook,
    Cook? cookDetail,

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
      cookDetail: cookDetail ?? this.cookDetail,

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
