// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Content {

 int? get contentId; String get contentName; String? get category; String? get subCategory; String? get brandName; int get count; DateTime? get regDate; DateTime? get expDate; String get storageArea; String? get memo; String? get nutriUnit; int? get nutriCapacity; int? get nutriKcal; int? get nutriCarbohydrate; int? get nutriProtein; int? get nutriFat;
/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentCopyWith<Content> get copyWith => _$ContentCopyWithImpl<Content>(this as Content, _$identity);

  /// Serializes this Content to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Content&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.contentName, contentName) || other.contentName == contentName)&&(identical(other.category, category) || other.category == category)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.count, count) || other.count == count)&&(identical(other.regDate, regDate) || other.regDate == regDate)&&(identical(other.expDate, expDate) || other.expDate == expDate)&&(identical(other.storageArea, storageArea) || other.storageArea == storageArea)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.nutriUnit, nutriUnit) || other.nutriUnit == nutriUnit)&&(identical(other.nutriCapacity, nutriCapacity) || other.nutriCapacity == nutriCapacity)&&(identical(other.nutriKcal, nutriKcal) || other.nutriKcal == nutriKcal)&&(identical(other.nutriCarbohydrate, nutriCarbohydrate) || other.nutriCarbohydrate == nutriCarbohydrate)&&(identical(other.nutriProtein, nutriProtein) || other.nutriProtein == nutriProtein)&&(identical(other.nutriFat, nutriFat) || other.nutriFat == nutriFat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentId,contentName,category,subCategory,brandName,count,regDate,expDate,storageArea,memo,nutriUnit,nutriCapacity,nutriKcal,nutriCarbohydrate,nutriProtein,nutriFat);

@override
String toString() {
  return 'Content(contentId: $contentId, contentName: $contentName, category: $category, subCategory: $subCategory, brandName: $brandName, count: $count, regDate: $regDate, expDate: $expDate, storageArea: $storageArea, memo: $memo, nutriUnit: $nutriUnit, nutriCapacity: $nutriCapacity, nutriKcal: $nutriKcal, nutriCarbohydrate: $nutriCarbohydrate, nutriProtein: $nutriProtein, nutriFat: $nutriFat)';
}


}

/// @nodoc
abstract mixin class $ContentCopyWith<$Res>  {
  factory $ContentCopyWith(Content value, $Res Function(Content) _then) = _$ContentCopyWithImpl;
@useResult
$Res call({
 int? contentId, String contentName, String? category, String? subCategory, String? brandName, int count, DateTime? regDate, DateTime? expDate, String storageArea, String? memo, String? nutriUnit, int? nutriCapacity, int? nutriKcal, int? nutriCarbohydrate, int? nutriProtein, int? nutriFat
});




}
/// @nodoc
class _$ContentCopyWithImpl<$Res>
    implements $ContentCopyWith<$Res> {
  _$ContentCopyWithImpl(this._self, this._then);

  final Content _self;
  final $Res Function(Content) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentId = freezed,Object? contentName = null,Object? category = freezed,Object? subCategory = freezed,Object? brandName = freezed,Object? count = null,Object? regDate = freezed,Object? expDate = freezed,Object? storageArea = null,Object? memo = freezed,Object? nutriUnit = freezed,Object? nutriCapacity = freezed,Object? nutriKcal = freezed,Object? nutriCarbohydrate = freezed,Object? nutriProtein = freezed,Object? nutriFat = freezed,}) {
  return _then(_self.copyWith(
contentId: freezed == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as int?,contentName: null == contentName ? _self.contentName : contentName // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,regDate: freezed == regDate ? _self.regDate : regDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expDate: freezed == expDate ? _self.expDate : expDate // ignore: cast_nullable_to_non_nullable
as DateTime?,storageArea: null == storageArea ? _self.storageArea : storageArea // ignore: cast_nullable_to_non_nullable
as String,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,nutriUnit: freezed == nutriUnit ? _self.nutriUnit : nutriUnit // ignore: cast_nullable_to_non_nullable
as String?,nutriCapacity: freezed == nutriCapacity ? _self.nutriCapacity : nutriCapacity // ignore: cast_nullable_to_non_nullable
as int?,nutriKcal: freezed == nutriKcal ? _self.nutriKcal : nutriKcal // ignore: cast_nullable_to_non_nullable
as int?,nutriCarbohydrate: freezed == nutriCarbohydrate ? _self.nutriCarbohydrate : nutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as int?,nutriProtein: freezed == nutriProtein ? _self.nutriProtein : nutriProtein // ignore: cast_nullable_to_non_nullable
as int?,nutriFat: freezed == nutriFat ? _self.nutriFat : nutriFat // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Content implements Content {
  const _Content({required this.contentId, required this.contentName, required this.category, required this.subCategory, required this.brandName, required this.count, required this.regDate, required this.expDate, required this.storageArea, required this.memo, required this.nutriUnit, required this.nutriCapacity, required this.nutriKcal, required this.nutriCarbohydrate, required this.nutriProtein, required this.nutriFat});
  factory _Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

@override final  int? contentId;
@override final  String contentName;
@override final  String? category;
@override final  String? subCategory;
@override final  String? brandName;
@override final  int count;
@override final  DateTime? regDate;
@override final  DateTime? expDate;
@override final  String storageArea;
@override final  String? memo;
@override final  String? nutriUnit;
@override final  int? nutriCapacity;
@override final  int? nutriKcal;
@override final  int? nutriCarbohydrate;
@override final  int? nutriProtein;
@override final  int? nutriFat;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentCopyWith<_Content> get copyWith => __$ContentCopyWithImpl<_Content>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Content&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.contentName, contentName) || other.contentName == contentName)&&(identical(other.category, category) || other.category == category)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.count, count) || other.count == count)&&(identical(other.regDate, regDate) || other.regDate == regDate)&&(identical(other.expDate, expDate) || other.expDate == expDate)&&(identical(other.storageArea, storageArea) || other.storageArea == storageArea)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.nutriUnit, nutriUnit) || other.nutriUnit == nutriUnit)&&(identical(other.nutriCapacity, nutriCapacity) || other.nutriCapacity == nutriCapacity)&&(identical(other.nutriKcal, nutriKcal) || other.nutriKcal == nutriKcal)&&(identical(other.nutriCarbohydrate, nutriCarbohydrate) || other.nutriCarbohydrate == nutriCarbohydrate)&&(identical(other.nutriProtein, nutriProtein) || other.nutriProtein == nutriProtein)&&(identical(other.nutriFat, nutriFat) || other.nutriFat == nutriFat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentId,contentName,category,subCategory,brandName,count,regDate,expDate,storageArea,memo,nutriUnit,nutriCapacity,nutriKcal,nutriCarbohydrate,nutriProtein,nutriFat);

@override
String toString() {
  return 'Content(contentId: $contentId, contentName: $contentName, category: $category, subCategory: $subCategory, brandName: $brandName, count: $count, regDate: $regDate, expDate: $expDate, storageArea: $storageArea, memo: $memo, nutriUnit: $nutriUnit, nutriCapacity: $nutriCapacity, nutriKcal: $nutriKcal, nutriCarbohydrate: $nutriCarbohydrate, nutriProtein: $nutriProtein, nutriFat: $nutriFat)';
}


}

/// @nodoc
abstract mixin class _$ContentCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) _then) = __$ContentCopyWithImpl;
@override @useResult
$Res call({
 int? contentId, String contentName, String? category, String? subCategory, String? brandName, int count, DateTime? regDate, DateTime? expDate, String storageArea, String? memo, String? nutriUnit, int? nutriCapacity, int? nutriKcal, int? nutriCarbohydrate, int? nutriProtein, int? nutriFat
});




}
/// @nodoc
class __$ContentCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(this._self, this._then);

  final _Content _self;
  final $Res Function(_Content) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentId = freezed,Object? contentName = null,Object? category = freezed,Object? subCategory = freezed,Object? brandName = freezed,Object? count = null,Object? regDate = freezed,Object? expDate = freezed,Object? storageArea = null,Object? memo = freezed,Object? nutriUnit = freezed,Object? nutriCapacity = freezed,Object? nutriKcal = freezed,Object? nutriCarbohydrate = freezed,Object? nutriProtein = freezed,Object? nutriFat = freezed,}) {
  return _then(_Content(
contentId: freezed == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as int?,contentName: null == contentName ? _self.contentName : contentName // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,regDate: freezed == regDate ? _self.regDate : regDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expDate: freezed == expDate ? _self.expDate : expDate // ignore: cast_nullable_to_non_nullable
as DateTime?,storageArea: null == storageArea ? _self.storageArea : storageArea // ignore: cast_nullable_to_non_nullable
as String,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,nutriUnit: freezed == nutriUnit ? _self.nutriUnit : nutriUnit // ignore: cast_nullable_to_non_nullable
as String?,nutriCapacity: freezed == nutriCapacity ? _self.nutriCapacity : nutriCapacity // ignore: cast_nullable_to_non_nullable
as int?,nutriKcal: freezed == nutriKcal ? _self.nutriKcal : nutriKcal // ignore: cast_nullable_to_non_nullable
as int?,nutriCarbohydrate: freezed == nutriCarbohydrate ? _self.nutriCarbohydrate : nutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as int?,nutriProtein: freezed == nutriProtein ? _self.nutriProtein : nutriProtein // ignore: cast_nullable_to_non_nullable
as int?,nutriFat: freezed == nutriFat ? _self.nutriFat : nutriFat // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
