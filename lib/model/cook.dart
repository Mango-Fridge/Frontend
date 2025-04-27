import 'content.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'cook.freezed.dart';
part 'cook.g.dart';

@freezed
abstract class Cook with _$Cook {
  const factory Cook({
    final int? cookId,
    required String? cookName,
    required String? cookMemo,
    required int? cookNutriKcal,
    required int? cookNutriCarbohydrate,
    required int? cookNutriProtein,
    required int? cookNutriFat, 
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
    required String? itemName,
    required int? count,
    required String? category,
    required String? brandName,
    required String? storageArea,
    required String? nutriUnit,
    required int? nutriCapacity,
    required int? nutriKcal,
  }) = _CookItems;

  factory CookItems.fromJson(Map<String, dynamic> json) =>
      _$CookItemsFromJson(json);
}
