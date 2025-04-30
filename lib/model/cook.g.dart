// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Cook _$CookFromJson(Map<String, dynamic> json) => _Cook(
  cookId: (json['cookId'] as num?)?.toInt(),
  cookName: json['cookName'] as String?,
  cookMemo: json['cookMemo'] as String?,
  cookNutriKcal: (json['cookNutriKcal'] as num?)?.toInt(),
  cookNutriCarbohydrate: (json['cookNutriCarbohydrate'] as num?)?.toInt(),
  cookNutriProtein: (json['cookNutriProtein'] as num?)?.toInt(),
  cookNutriFat: (json['cookNutriFat'] as num?)?.toInt(),
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
  itemId: (json['itemId'] as num?)?.toInt(),
  cookItemName: json['cookItemName'] as String?,
  itemName: json['itemName'] as String?,
  count: (json['count'] as num?)?.toInt(),
  category: json['category'] as String?,
  brandName: json['brandName'] as String?,
  storageArea: json['storageArea'] as String?,
  nutriUnit: json['nutriUnit'] as String?,
  nutriCapacity: (json['nutriCapacity'] as num?)?.toInt(),
  nutriKcal: (json['nutriKcal'] as num?)?.toInt(),
  subCategory: json['subCategory'] as String?,
);

Map<String, dynamic> _$CookItemsToJson(_CookItems instance) =>
    <String, dynamic>{
      'cookItemId': instance.cookItemId,
      'itemId': instance.itemId,
      'cookItemName': instance.cookItemName,
      'itemName': instance.itemName,
      'count': instance.count,
      'category': instance.category,
      'brandName': instance.brandName,
      'storageArea': instance.storageArea,
      'nutriUnit': instance.nutriUnit,
      'nutriCapacity': instance.nutriCapacity,
      'nutriKcal': instance.nutriKcal,
      'subCategory': instance.subCategory,
    };
