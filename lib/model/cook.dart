import 'content.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'cook.freezed.dart';
part 'cook.g.dart';

@freezed
abstract class Cook with _$Cook {
  const factory Cook({
    required int? cookId,
    required String? cookName,
    required String? cookMemo,
    required String? cookNutriKcal,
    required String? cookNutriCarbohydrate,
    required String? cookNutriProtein,
    required String? cookingNutriFat,
    required List<CookItems>? cookItems,
    required int? groupId,
  }) = _Cook;

  factory Cook.fromJson(Map<String, dynamic> json) => _$CookFromJson(json);
}

@freezed
abstract class CookItems with _$CookItems {
  const factory CookItems({
    required int? cookItemId,
    required String? cookItemName,
  }) = _CookItems;

  factory CookItems.fromJson(Map<String, dynamic> json) =>
      _$CookItemsFromJson(json);
}
