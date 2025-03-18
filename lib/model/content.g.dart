// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Content _$ContentFromJson(Map<String, dynamic> json) => _Content(
  contentId: (json['contentId'] as num?)?.toInt(),
  contentName: json['contentName'] as String,
  category: json['category'] as String?,
  count: (json['count'] as num).toInt(),
  regDate:
      json['regDate'] == null
          ? null
          : DateTime.parse(json['regDate'] as String),
  expDate:
      json['expDate'] == null
          ? null
          : DateTime.parse(json['expDate'] as String),
  storageArea: json['storageArea'] as String,
  memo: json['memo'] as String?,
  nutriUnit: json['nutriUnit'] as String?,
  nutriCapacity: (json['nutriCapacity'] as num?)?.toInt(),
  nutriKcal: (json['nutriKcal'] as num?)?.toInt(),
  nutriCarbohydrate: (json['nutriCarbohydrate'] as num?)?.toInt(),
  nutriProtein: (json['nutriProtein'] as num?)?.toInt(),
  nutriFat: (json['nutriFat'] as num?)?.toInt(),
);

Map<String, dynamic> _$ContentToJson(_Content instance) => <String, dynamic>{
  'contentId': instance.contentId,
  'contentName': instance.contentName,
  'category': instance.category,
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
};
