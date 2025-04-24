// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addCook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddCook _$AddCookFromJson(Map<String, dynamic> json) => _AddCook(
  cookId: (json['cookId'] as num?)?.toInt(),
  cookName: json['cookName'] as String?,
  cookMemo: json['cookMemo'] as String?,
  cookNutriKcal: (json['cookNutriKcal'] as num?)?.toDouble(),
  cookNutriCarbohydrate: (json['cookNutriCarbohydrate'] as num?)?.toDouble(),
  cookNutriProtein: (json['cookNutriProtein'] as num?)?.toDouble(),
  cookNutriFat: (json['cookNutriFat'] as num?)?.toDouble(),
  groupId: (json['groupId'] as num?)?.toInt(),
  cookItems:
      (json['cookItems'] as List<dynamic>?)
          ?.map((e) => AddCookItem.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AddCookToJson(_AddCook instance) => <String, dynamic>{
  'cookId': instance.cookId,
  'cookName': instance.cookName,
  'cookMemo': instance.cookMemo,
  'cookNutriKcal': instance.cookNutriKcal,
  'cookNutriCarbohydrate': instance.cookNutriCarbohydrate,
  'cookNutriProtein': instance.cookNutriProtein,
  'cookNutriFat': instance.cookNutriFat,
  'groupId': instance.groupId,
  'cookItems': instance.cookItems,
};

_AddCookItem _$AddCookItemFromJson(Map<String, dynamic> json) => _AddCookItem(
  itemName: json['itemName'] as String?,
  count: (json['count'] as num?)?.toInt(),
  category: json['category'] as String?,
  brandName: json['brandName'] as String?,
  storageArea: json['storageArea'] as String?,
  nutriUnit: json['nutriUnit'] as String?,
  nutriCapacity: (json['nutriCapacity'] as num?)?.toDouble(),
  nutriKcal: (json['nutriKcal'] as num?)?.toDouble(),
);

Map<String, dynamic> _$AddCookItemToJson(_AddCookItem instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'count': instance.count,
      'category': instance.category,
      'brandName': instance.brandName,
      'storageArea': instance.storageArea,
      'nutriUnit': instance.nutriUnit,
      'nutriCapacity': instance.nutriCapacity,
      'nutriKcal': instance.nutriKcal,
    };
