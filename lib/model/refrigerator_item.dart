import 'package:freezed_annotation/freezed_annotation.dart';

part 'refrigerator_item.freezed.dart';
part 'refrigerator_item.g.dart';

@freezed
abstract class RefrigeratorItem with _$RefrigeratorItem {
  const factory RefrigeratorItem({
    required int? itemId,
    required String? itemName,
    required String? category,
    required String? subCategory,
    required String? brandName,
    required int? count,
    required DateTime? regDate,
    required DateTime? expDate,
    required String? storageArea,
    required String? memo,
    required String? nutriUnit,
    required int? nutriCapacity,
    required int? nutriKcal,
    required int? nutriCarbohydrate,
    required int? nutriProtein,
    required int? nutriFat,
    required bool? openItem,
  }) = Refrigerator;

  factory RefrigeratorItem.fromJson(Map<String, dynamic> json) =>
      _$RefrigeratorItemFromJson(json);
}
