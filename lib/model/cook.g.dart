// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Cook _$CookFromJson(Map<String, dynamic> json) => _Cook(
  groupID: (json['groupID'] as num).toInt(),
  cookID: (json['cookID'] as num).toInt(),
  cookName: json['cookName'] as String,
  cookMemo: json['cookMemo'] as String,
  cookNutriKcal: json['cookNutriKcal'] as String,
  cookNutriCarbohydrate: json['cookNutriCarbohydrate'] as String,
  cookingNutriFat: json['cookingNutriFat'] as String,
  cookNutriProtein: json['cookNutriProtein'] as String,
  cookItems:
      (json['cookItems'] as List<dynamic>)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CookToJson(_Cook instance) => <String, dynamic>{
  'groupID': instance.groupID,
  'cookID': instance.cookID,
  'cookName': instance.cookName,
  'cookMemo': instance.cookMemo,
  'cookNutriKcal': instance.cookNutriKcal,
  'cookNutriCarbohydrate': instance.cookNutriCarbohydrate,
  'cookingNutriFat': instance.cookingNutriFat,
  'cookNutriProtein': instance.cookNutriProtein,
  'cookItems': instance.cookItems,
};
