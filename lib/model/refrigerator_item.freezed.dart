// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refrigerator_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
RefrigeratorItem _$RefrigeratorItemFromJson(
  Map<String, dynamic> json
) {
    return Refrigerator.fromJson(
      json
    );
}

/// @nodoc
mixin _$RefrigeratorItem {

 int? get itemId; String? get itemName; String? get category; String? get subCategory; String? get brandName; int? get count; DateTime? get regDate; DateTime? get expDate; String? get storageArea; String? get memo; String? get nutriUnit; int? get nutriCapacity; int? get nutriKcal; int? get nutriCarbohydrate; int? get nutriProtein; int? get nutriFat; bool? get openItem;
/// Create a copy of RefrigeratorItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefrigeratorItemCopyWith<RefrigeratorItem> get copyWith => _$RefrigeratorItemCopyWithImpl<RefrigeratorItem>(this as RefrigeratorItem, _$identity);

  /// Serializes this RefrigeratorItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefrigeratorItem&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.category, category) || other.category == category)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.count, count) || other.count == count)&&(identical(other.regDate, regDate) || other.regDate == regDate)&&(identical(other.expDate, expDate) || other.expDate == expDate)&&(identical(other.storageArea, storageArea) || other.storageArea == storageArea)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.nutriUnit, nutriUnit) || other.nutriUnit == nutriUnit)&&(identical(other.nutriCapacity, nutriCapacity) || other.nutriCapacity == nutriCapacity)&&(identical(other.nutriKcal, nutriKcal) || other.nutriKcal == nutriKcal)&&(identical(other.nutriCarbohydrate, nutriCarbohydrate) || other.nutriCarbohydrate == nutriCarbohydrate)&&(identical(other.nutriProtein, nutriProtein) || other.nutriProtein == nutriProtein)&&(identical(other.nutriFat, nutriFat) || other.nutriFat == nutriFat)&&(identical(other.openItem, openItem) || other.openItem == openItem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemId,itemName,category,subCategory,brandName,count,regDate,expDate,storageArea,memo,nutriUnit,nutriCapacity,nutriKcal,nutriCarbohydrate,nutriProtein,nutriFat,openItem);

@override
String toString() {
  return 'RefrigeratorItem(itemId: $itemId, itemName: $itemName, category: $category, subCategory: $subCategory, brandName: $brandName, count: $count, regDate: $regDate, expDate: $expDate, storageArea: $storageArea, memo: $memo, nutriUnit: $nutriUnit, nutriCapacity: $nutriCapacity, nutriKcal: $nutriKcal, nutriCarbohydrate: $nutriCarbohydrate, nutriProtein: $nutriProtein, nutriFat: $nutriFat, openItem: $openItem)';
}


}

/// @nodoc
abstract mixin class $RefrigeratorItemCopyWith<$Res>  {
  factory $RefrigeratorItemCopyWith(RefrigeratorItem value, $Res Function(RefrigeratorItem) _then) = _$RefrigeratorItemCopyWithImpl;
@useResult
$Res call({
 int? itemId, String? itemName, String? category, String? subCategory, String? brandName, int? count, DateTime? regDate, DateTime? expDate, String? storageArea, String? memo, String? nutriUnit, int? nutriCapacity, int? nutriKcal, int? nutriCarbohydrate, int? nutriProtein, int? nutriFat, bool? openItem
});




}
/// @nodoc
class _$RefrigeratorItemCopyWithImpl<$Res>
    implements $RefrigeratorItemCopyWith<$Res> {
  _$RefrigeratorItemCopyWithImpl(this._self, this._then);

  final RefrigeratorItem _self;
  final $Res Function(RefrigeratorItem) _then;

/// Create a copy of RefrigeratorItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemId = freezed,Object? itemName = freezed,Object? category = freezed,Object? subCategory = freezed,Object? brandName = freezed,Object? count = freezed,Object? regDate = freezed,Object? expDate = freezed,Object? storageArea = freezed,Object? memo = freezed,Object? nutriUnit = freezed,Object? nutriCapacity = freezed,Object? nutriKcal = freezed,Object? nutriCarbohydrate = freezed,Object? nutriProtein = freezed,Object? nutriFat = freezed,Object? openItem = freezed,}) {
  return _then(_self.copyWith(
itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int?,itemName: freezed == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,regDate: freezed == regDate ? _self.regDate : regDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expDate: freezed == expDate ? _self.expDate : expDate // ignore: cast_nullable_to_non_nullable
as DateTime?,storageArea: freezed == storageArea ? _self.storageArea : storageArea // ignore: cast_nullable_to_non_nullable
as String?,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,nutriUnit: freezed == nutriUnit ? _self.nutriUnit : nutriUnit // ignore: cast_nullable_to_non_nullable
as String?,nutriCapacity: freezed == nutriCapacity ? _self.nutriCapacity : nutriCapacity // ignore: cast_nullable_to_non_nullable
as int?,nutriKcal: freezed == nutriKcal ? _self.nutriKcal : nutriKcal // ignore: cast_nullable_to_non_nullable
as int?,nutriCarbohydrate: freezed == nutriCarbohydrate ? _self.nutriCarbohydrate : nutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as int?,nutriProtein: freezed == nutriProtein ? _self.nutriProtein : nutriProtein // ignore: cast_nullable_to_non_nullable
as int?,nutriFat: freezed == nutriFat ? _self.nutriFat : nutriFat // ignore: cast_nullable_to_non_nullable
as int?,openItem: freezed == openItem ? _self.openItem : openItem // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class Refrigerator implements RefrigeratorItem {
  const Refrigerator({required this.itemId, required this.itemName, required this.category, required this.subCategory, required this.brandName, required this.count, required this.regDate, required this.expDate, required this.storageArea, required this.memo, required this.nutriUnit, required this.nutriCapacity, required this.nutriKcal, required this.nutriCarbohydrate, required this.nutriProtein, required this.nutriFat, required this.openItem});
  factory Refrigerator.fromJson(Map<String, dynamic> json) => _$RefrigeratorFromJson(json);

@override final  int? itemId;
@override final  String? itemName;
@override final  String? category;
@override final  String? subCategory;
@override final  String? brandName;
@override final  int? count;
@override final  DateTime? regDate;
@override final  DateTime? expDate;
@override final  String? storageArea;
@override final  String? memo;
@override final  String? nutriUnit;
@override final  int? nutriCapacity;
@override final  int? nutriKcal;
@override final  int? nutriCarbohydrate;
@override final  int? nutriProtein;
@override final  int? nutriFat;
@override final  bool? openItem;

/// Create a copy of RefrigeratorItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefrigeratorCopyWith<Refrigerator> get copyWith => _$RefrigeratorCopyWithImpl<Refrigerator>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RefrigeratorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Refrigerator&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.category, category) || other.category == category)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.count, count) || other.count == count)&&(identical(other.regDate, regDate) || other.regDate == regDate)&&(identical(other.expDate, expDate) || other.expDate == expDate)&&(identical(other.storageArea, storageArea) || other.storageArea == storageArea)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.nutriUnit, nutriUnit) || other.nutriUnit == nutriUnit)&&(identical(other.nutriCapacity, nutriCapacity) || other.nutriCapacity == nutriCapacity)&&(identical(other.nutriKcal, nutriKcal) || other.nutriKcal == nutriKcal)&&(identical(other.nutriCarbohydrate, nutriCarbohydrate) || other.nutriCarbohydrate == nutriCarbohydrate)&&(identical(other.nutriProtein, nutriProtein) || other.nutriProtein == nutriProtein)&&(identical(other.nutriFat, nutriFat) || other.nutriFat == nutriFat)&&(identical(other.openItem, openItem) || other.openItem == openItem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemId,itemName,category,subCategory,brandName,count,regDate,expDate,storageArea,memo,nutriUnit,nutriCapacity,nutriKcal,nutriCarbohydrate,nutriProtein,nutriFat,openItem);

@override
String toString() {
  return 'RefrigeratorItem(itemId: $itemId, itemName: $itemName, category: $category, subCategory: $subCategory, brandName: $brandName, count: $count, regDate: $regDate, expDate: $expDate, storageArea: $storageArea, memo: $memo, nutriUnit: $nutriUnit, nutriCapacity: $nutriCapacity, nutriKcal: $nutriKcal, nutriCarbohydrate: $nutriCarbohydrate, nutriProtein: $nutriProtein, nutriFat: $nutriFat, openItem: $openItem)';
}


}

/// @nodoc
abstract mixin class $RefrigeratorCopyWith<$Res> implements $RefrigeratorItemCopyWith<$Res> {
  factory $RefrigeratorCopyWith(Refrigerator value, $Res Function(Refrigerator) _then) = _$RefrigeratorCopyWithImpl;
@override @useResult
$Res call({
 int? itemId, String? itemName, String? category, String? subCategory, String? brandName, int? count, DateTime? regDate, DateTime? expDate, String? storageArea, String? memo, String? nutriUnit, int? nutriCapacity, int? nutriKcal, int? nutriCarbohydrate, int? nutriProtein, int? nutriFat, bool? openItem
});




}
/// @nodoc
class _$RefrigeratorCopyWithImpl<$Res>
    implements $RefrigeratorCopyWith<$Res> {
  _$RefrigeratorCopyWithImpl(this._self, this._then);

  final Refrigerator _self;
  final $Res Function(Refrigerator) _then;

/// Create a copy of RefrigeratorItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemId = freezed,Object? itemName = freezed,Object? category = freezed,Object? subCategory = freezed,Object? brandName = freezed,Object? count = freezed,Object? regDate = freezed,Object? expDate = freezed,Object? storageArea = freezed,Object? memo = freezed,Object? nutriUnit = freezed,Object? nutriCapacity = freezed,Object? nutriKcal = freezed,Object? nutriCarbohydrate = freezed,Object? nutriProtein = freezed,Object? nutriFat = freezed,Object? openItem = freezed,}) {
  return _then(Refrigerator(
itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int?,itemName: freezed == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,regDate: freezed == regDate ? _self.regDate : regDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expDate: freezed == expDate ? _self.expDate : expDate // ignore: cast_nullable_to_non_nullable
as DateTime?,storageArea: freezed == storageArea ? _self.storageArea : storageArea // ignore: cast_nullable_to_non_nullable
as String?,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,nutriUnit: freezed == nutriUnit ? _self.nutriUnit : nutriUnit // ignore: cast_nullable_to_non_nullable
as String?,nutriCapacity: freezed == nutriCapacity ? _self.nutriCapacity : nutriCapacity // ignore: cast_nullable_to_non_nullable
as int?,nutriKcal: freezed == nutriKcal ? _self.nutriKcal : nutriKcal // ignore: cast_nullable_to_non_nullable
as int?,nutriCarbohydrate: freezed == nutriCarbohydrate ? _self.nutriCarbohydrate : nutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as int?,nutriProtein: freezed == nutriProtein ? _self.nutriProtein : nutriProtein // ignore: cast_nullable_to_non_nullable
as int?,nutriFat: freezed == nutriFat ? _self.nutriFat : nutriFat // ignore: cast_nullable_to_non_nullable
as int?,openItem: freezed == openItem ? _self.openItem : openItem // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
