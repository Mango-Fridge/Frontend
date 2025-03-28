import 'content.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'cook.freezed.dart';
part 'cook.g.dart';

@freezed
abstract class Cook with _$Cook {
  const factory Cook({
    required int groupID,
    required String cookingName,
    required String cookingMemo,
    required String cookingNutriKcal,
    required String cookingNutriCarbohydrate,
    required String cookingNutriFat,
    required String cookingNutriProtein,
    required List<Content> cookingItems,
  }) = _Cook;

  factory Cook.fromJson(Map<String, dynamic> json) => _$CookFromJson(json);
}
