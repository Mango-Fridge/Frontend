import 'content.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'cook.freezed.dart';
part 'cook.g.dart';

@freezed
abstract class Cook with _$Cook {
  const factory Cook({
    final int? cookId,
    final String? cookName,
    final String? cookMemo,
    final int? cookNutriKcal,
    final int? cookNutriCarbohydrate,
    final int? cookNutriProtein,
    final int? cookNutriFat, 
    final List<CookItems>? cookItems,
    final int? groupId,
  }) = _Cook;

  factory Cook.fromJson(Map<String, dynamic> json) => _$CookFromJson(json);
}

@freezed
abstract class CookItems with _$CookItems {
  const factory CookItems({
    required int? cookItemId,
    final int? itemId,
    required String? cookItemName,
    required String? itemName,
    required int? count,
    required String? category,
    required String? brandName,
    required String? storageArea,
    required String? nutriUnit,
    required int? nutriCapacity,
    required int? nutriKcal,
    required String? subCategory,
  }) = _CookItems;

  factory CookItems.fromJson(Map<String, dynamic> json) =>
      _$CookItemsFromJson(json);
}
