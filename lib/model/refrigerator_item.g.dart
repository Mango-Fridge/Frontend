// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refrigerator_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Refrigerator _$RefrigeratorFromJson(Map<String, dynamic> json) => Refrigerator(
  itemId: (json['itemId'] as num?)?.toInt(),
  itemName: json['itemName'] as String?,
  category: json['category'] as String?,
  subCategory: json['subCategory'] as String?,
  brandName: json['brandName'] as String?,
  count: (json['count'] as num?)?.toInt(),
  regDate:
      json['regDate'] == null
          ? null
          : DateTime.parse(json['regDate'] as String),
  expDate:
      json['expDate'] == null
          ? null
          : DateTime.parse(json['expDate'] as String),
  storageArea: json['storageArea'] as String?,
  memo: json['memo'] as String?,
  nutriUnit: json['nutriUnit'] as String?,
  nutriCapacity: (json['nutriCapacity'] as num?)?.toInt(),
  nutriKcal: (json['nutriKcal'] as num?)?.toInt(),
  nutriCarbohydrate: (json['nutriCarbohydrate'] as num?)?.toInt(),
  nutriProtein: (json['nutriProtein'] as num?)?.toInt(),
  nutriFat: (json['nutriFat'] as num?)?.toInt(),
  openItem: json['openItem'] as bool?,
);

Map<String, dynamic> _$RefrigeratorToJson(Refrigerator instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'brandName': instance.brandName,
      'count': instance.count,
      'regDate': instance.regDate?.toIso8601String(),
      'expDate': instance.expDate?.toIso8601String(),
      'storageArea': instance.storageArea,
      'memo': instance.memo,
      'nutriUnit': instance.nutriUnit,
      'nutriCapacity': instance.nutriCapacity,
      'nutriKcal': instance.nutriKcal,
      'nutriCarbohydrate': instance.nutriCarbohydrate,
      'nutriProtein': instance.nutriProtein,
      'nutriFat': instance.nutriFat,
      'openItem': instance.openItem,
    };
