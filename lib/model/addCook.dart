import 'package:freezed_annotation/freezed_annotation.dart';
part 'addCook.freezed.dart';
part 'addCook.g.dart';

@freezed
abstract class AddCook with _$AddCook {
  const factory AddCook({
    final int? cookId,
    required String? cookName,
    required String? cookMemo,
    required double? cookNutriKcal,
    required double? cookNutriCarbohydrate,
    required double? cookNutriProtein,
    required double? cookNutriFat,
    required int? groupId,
    final List<AddCookItem>? cookItems,
  }) = _AddCook;

  factory AddCook.fromJson(Map<String, dynamic> json) =>
      _$AddCookFromJson(json);
}

@freezed
abstract class AddCookItem with _$AddCookItem {
  const factory AddCookItem({
    required String? itemName,
    required int? count,
    required String? category,
    required String? brandName,
    required String? storageArea,
    required String? nutriUnit,
    required double? nutriCapacity,
    required double? nutriKcal,
  }) = _AddCookItem;

  factory AddCookItem.fromJson(Map<String, dynamic> json) =>
      _$AddCookItemFromJson(json);
}
