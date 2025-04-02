// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Cook _$CookFromJson(Map<String, dynamic> json) => _Cook(
  cookId: (json['cookId'] as num?)?.toInt(),
  cookName: json['cookName'] as String?,
  cookMemo: json['cookMemo'] as String?,
  cookNutriKcal: json['cookNutriKcal'] as String?,
  cookNutriCarbohydrate: json['cookNutriCarbohydrate'] as String?,
  cookNutriProtein: json['cookNutriProtein'] as String?,
  cookNutriFat: json['cookNutriFat'] as String?,
  cookItems:
      (json['cookItems'] as List<dynamic>?)
          ?.map((e) => CookItems.fromJson(e as Map<String, dynamic>))
          .toList(),
  groupId: (json['groupId'] as num?)?.toInt(),
);

Map<String, dynamic> _$CookToJson(_Cook instance) => <String, dynamic>{
  'cookId': instance.cookId,
  'cookName': instance.cookName,
  'cookMemo': instance.cookMemo,
  'cookNutriKcal': instance.cookNutriKcal,
  'cookNutriCarbohydrate': instance.cookNutriCarbohydrate,
  'cookNutriProtein': instance.cookNutriProtein,
  'cookNutriFat': instance.cookNutriFat,
  'cookItems': instance.cookItems,
  'groupId': instance.groupId,
};

_CookItems _$CookItemsFromJson(Map<String, dynamic> json) => _CookItems(
  cookItemId: (json['cookItemId'] as num?)?.toInt(),
  cookItemName: json['cookItemName'] as String?,
);

Map<String, dynamic> _$CookItemsToJson(_CookItems instance) =>
    <String, dynamic>{
      'cookItemId': instance.cookItemId,
      'cookItemName': instance.cookItemName,
    };
