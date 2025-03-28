import 'content.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'cook.freezed.dart';
part 'cook.g.dart';

@freezed
abstract class Cook with _$Cook {
  const factory Cook({
    required int groupID,
    required int cookID,
    required String cookName,
    required String cookMemo,
    required String cookNutriKcal,
    required String cookNutriCarbohydrate,
    required String cookingNutriFat,
    required String cookNutriProtein,
    required List<Content> cookItems,
  }) = _Cook;

  factory Cook.fromJson(Map<String, dynamic> json) => _$CookFromJson(json);
}
