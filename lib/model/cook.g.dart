// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Cook _$CookFromJson(Map<String, dynamic> json) => _Cook(
  groupID: (json['groupID'] as num).toInt(),
  cookingName: json['cookingName'] as String,
  cookingMemo: json['cookingMemo'] as String,
  cookingNutriKcal: json['cookingNutriKcal'] as String,
  cookingNutriCarbohydrate: json['cookingNutriCarbohydrate'] as String,
  cookingNutriFat: json['cookingNutriFat'] as String,
  cookingNutriProtein: json['cookingNutriProtein'] as String,
  cookingItems:
      (json['cookingItems'] as List<dynamic>)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CookToJson(_Cook instance) => <String, dynamic>{
  'groupID': instance.groupID,
  'cookingName': instance.cookingName,
  'cookingMemo': instance.cookingMemo,
  'cookingNutriKcal': instance.cookingNutriKcal,
  'cookingNutriCarbohydrate': instance.cookingNutriCarbohydrate,
  'cookingNutriFat': instance.cookingNutriFat,
  'cookingNutriProtein': instance.cookingNutriProtein,
  'cookingItems': instance.cookingItems,
};
