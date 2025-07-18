// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Cook {

 int? get cookId; String? get cookName; String? get cookMemo; int? get cookNutriKcal; int? get cookNutriCarbohydrate; int? get cookNutriProtein; int? get cookNutriFat; List<CookItems>? get cookItems; int? get groupId;
/// Create a copy of Cook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CookCopyWith<Cook> get copyWith => _$CookCopyWithImpl<Cook>(this as Cook, _$identity);

  /// Serializes this Cook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cook&&(identical(other.cookId, cookId) || other.cookId == cookId)&&(identical(other.cookName, cookName) || other.cookName == cookName)&&(identical(other.cookMemo, cookMemo) || other.cookMemo == cookMemo)&&(identical(other.cookNutriKcal, cookNutriKcal) || other.cookNutriKcal == cookNutriKcal)&&(identical(other.cookNutriCarbohydrate, cookNutriCarbohydrate) || other.cookNutriCarbohydrate == cookNutriCarbohydrate)&&(identical(other.cookNutriProtein, cookNutriProtein) || other.cookNutriProtein == cookNutriProtein)&&(identical(other.cookNutriFat, cookNutriFat) || other.cookNutriFat == cookNutriFat)&&const DeepCollectionEquality().equals(other.cookItems, cookItems)&&(identical(other.groupId, groupId) || other.groupId == groupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cookId,cookName,cookMemo,cookNutriKcal,cookNutriCarbohydrate,cookNutriProtein,cookNutriFat,const DeepCollectionEquality().hash(cookItems),groupId);

@override
String toString() {
  return 'Cook(cookId: $cookId, cookName: $cookName, cookMemo: $cookMemo, cookNutriKcal: $cookNutriKcal, cookNutriCarbohydrate: $cookNutriCarbohydrate, cookNutriProtein: $cookNutriProtein, cookNutriFat: $cookNutriFat, cookItems: $cookItems, groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class $CookCopyWith<$Res>  {
  factory $CookCopyWith(Cook value, $Res Function(Cook) _then) = _$CookCopyWithImpl;
@useResult
$Res call({
 int? cookId, String? cookName, String? cookMemo, int? cookNutriKcal, int? cookNutriCarbohydrate, int? cookNutriProtein, int? cookNutriFat, List<CookItems>? cookItems, int? groupId
});




}
/// @nodoc
class _$CookCopyWithImpl<$Res>
    implements $CookCopyWith<$Res> {
  _$CookCopyWithImpl(this._self, this._then);

  final Cook _self;
  final $Res Function(Cook) _then;

/// Create a copy of Cook
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cookId = freezed,Object? cookName = freezed,Object? cookMemo = freezed,Object? cookNutriKcal = freezed,Object? cookNutriCarbohydrate = freezed,Object? cookNutriProtein = freezed,Object? cookNutriFat = freezed,Object? cookItems = freezed,Object? groupId = freezed,}) {
  return _then(_self.copyWith(
cookId: freezed == cookId ? _self.cookId : cookId // ignore: cast_nullable_to_non_nullable
as int?,cookName: freezed == cookName ? _self.cookName : cookName // ignore: cast_nullable_to_non_nullable
as String?,cookMemo: freezed == cookMemo ? _self.cookMemo : cookMemo // ignore: cast_nullable_to_non_nullable
as String?,cookNutriKcal: freezed == cookNutriKcal ? _self.cookNutriKcal : cookNutriKcal // ignore: cast_nullable_to_non_nullable
as int?,cookNutriCarbohydrate: freezed == cookNutriCarbohydrate ? _self.cookNutriCarbohydrate : cookNutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as int?,cookNutriProtein: freezed == cookNutriProtein ? _self.cookNutriProtein : cookNutriProtein // ignore: cast_nullable_to_non_nullable
as int?,cookNutriFat: freezed == cookNutriFat ? _self.cookNutriFat : cookNutriFat // ignore: cast_nullable_to_non_nullable
as int?,cookItems: freezed == cookItems ? _self.cookItems : cookItems // ignore: cast_nullable_to_non_nullable
as List<CookItems>?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Cook implements Cook {
  const _Cook({this.cookId, this.cookName, this.cookMemo, this.cookNutriKcal, this.cookNutriCarbohydrate, this.cookNutriProtein, this.cookNutriFat, final  List<CookItems>? cookItems, this.groupId}): _cookItems = cookItems;
  factory _Cook.fromJson(Map<String, dynamic> json) => _$CookFromJson(json);

@override final  int? cookId;
@override final  String? cookName;
@override final  String? cookMemo;
@override final  int? cookNutriKcal;
@override final  int? cookNutriCarbohydrate;
@override final  int? cookNutriProtein;
@override final  int? cookNutriFat;
 final  List<CookItems>? _cookItems;
@override List<CookItems>? get cookItems {
  final value = _cookItems;
  if (value == null) return null;
  if (_cookItems is EqualUnmodifiableListView) return _cookItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? groupId;

/// Create a copy of Cook
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CookCopyWith<_Cook> get copyWith => __$CookCopyWithImpl<_Cook>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CookToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cook&&(identical(other.cookId, cookId) || other.cookId == cookId)&&(identical(other.cookName, cookName) || other.cookName == cookName)&&(identical(other.cookMemo, cookMemo) || other.cookMemo == cookMemo)&&(identical(other.cookNutriKcal, cookNutriKcal) || other.cookNutriKcal == cookNutriKcal)&&(identical(other.cookNutriCarbohydrate, cookNutriCarbohydrate) || other.cookNutriCarbohydrate == cookNutriCarbohydrate)&&(identical(other.cookNutriProtein, cookNutriProtein) || other.cookNutriProtein == cookNutriProtein)&&(identical(other.cookNutriFat, cookNutriFat) || other.cookNutriFat == cookNutriFat)&&const DeepCollectionEquality().equals(other._cookItems, _cookItems)&&(identical(other.groupId, groupId) || other.groupId == groupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cookId,cookName,cookMemo,cookNutriKcal,cookNutriCarbohydrate,cookNutriProtein,cookNutriFat,const DeepCollectionEquality().hash(_cookItems),groupId);

@override
String toString() {
  return 'Cook(cookId: $cookId, cookName: $cookName, cookMemo: $cookMemo, cookNutriKcal: $cookNutriKcal, cookNutriCarbohydrate: $cookNutriCarbohydrate, cookNutriProtein: $cookNutriProtein, cookNutriFat: $cookNutriFat, cookItems: $cookItems, groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$CookCopyWith<$Res> implements $CookCopyWith<$Res> {
  factory _$CookCopyWith(_Cook value, $Res Function(_Cook) _then) = __$CookCopyWithImpl;
@override @useResult
$Res call({
 int? cookId, String? cookName, String? cookMemo, int? cookNutriKcal, int? cookNutriCarbohydrate, int? cookNutriProtein, int? cookNutriFat, List<CookItems>? cookItems, int? groupId
});




}
/// @nodoc
class __$CookCopyWithImpl<$Res>
    implements _$CookCopyWith<$Res> {
  __$CookCopyWithImpl(this._self, this._then);

  final _Cook _self;
  final $Res Function(_Cook) _then;

/// Create a copy of Cook
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cookId = freezed,Object? cookName = freezed,Object? cookMemo = freezed,Object? cookNutriKcal = freezed,Object? cookNutriCarbohydrate = freezed,Object? cookNutriProtein = freezed,Object? cookNutriFat = freezed,Object? cookItems = freezed,Object? groupId = freezed,}) {
  return _then(_Cook(
cookId: freezed == cookId ? _self.cookId : cookId // ignore: cast_nullable_to_non_nullable
as int?,cookName: freezed == cookName ? _self.cookName : cookName // ignore: cast_nullable_to_non_nullable
as String?,cookMemo: freezed == cookMemo ? _self.cookMemo : cookMemo // ignore: cast_nullable_to_non_nullable
as String?,cookNutriKcal: freezed == cookNutriKcal ? _self.cookNutriKcal : cookNutriKcal // ignore: cast_nullable_to_non_nullable
as int?,cookNutriCarbohydrate: freezed == cookNutriCarbohydrate ? _self.cookNutriCarbohydrate : cookNutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as int?,cookNutriProtein: freezed == cookNutriProtein ? _self.cookNutriProtein : cookNutriProtein // ignore: cast_nullable_to_non_nullable
as int?,cookNutriFat: freezed == cookNutriFat ? _self.cookNutriFat : cookNutriFat // ignore: cast_nullable_to_non_nullable
as int?,cookItems: freezed == cookItems ? _self._cookItems : cookItems // ignore: cast_nullable_to_non_nullable
as List<CookItems>?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CookItems {

 int? get cookItemId; int? get itemId; String? get cookItemName; String? get itemName; int? get count; String? get category; String? get brandName; String? get storageArea; String? get nutriUnit; int? get nutriCapacity; int? get nutriKcal; String? get subCategory;
/// Create a copy of CookItems
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CookItemsCopyWith<CookItems> get copyWith => _$CookItemsCopyWithImpl<CookItems>(this as CookItems, _$identity);

  /// Serializes this CookItems to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CookItems&&(identical(other.cookItemId, cookItemId) || other.cookItemId == cookItemId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.cookItemName, cookItemName) || other.cookItemName == cookItemName)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.count, count) || other.count == count)&&(identical(other.category, category) || other.category == category)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.storageArea, storageArea) || other.storageArea == storageArea)&&(identical(other.nutriUnit, nutriUnit) || other.nutriUnit == nutriUnit)&&(identical(other.nutriCapacity, nutriCapacity) || other.nutriCapacity == nutriCapacity)&&(identical(other.nutriKcal, nutriKcal) || other.nutriKcal == nutriKcal)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cookItemId,itemId,cookItemName,itemName,count,category,brandName,storageArea,nutriUnit,nutriCapacity,nutriKcal,subCategory);

@override
String toString() {
  return 'CookItems(cookItemId: $cookItemId, itemId: $itemId, cookItemName: $cookItemName, itemName: $itemName, count: $count, category: $category, brandName: $brandName, storageArea: $storageArea, nutriUnit: $nutriUnit, nutriCapacity: $nutriCapacity, nutriKcal: $nutriKcal, subCategory: $subCategory)';
}


}

/// @nodoc
abstract mixin class $CookItemsCopyWith<$Res>  {
  factory $CookItemsCopyWith(CookItems value, $Res Function(CookItems) _then) = _$CookItemsCopyWithImpl;
@useResult
$Res call({
 int? cookItemId, int? itemId, String? cookItemName, String? itemName, int? count, String? category, String? brandName, String? storageArea, String? nutriUnit, int? nutriCapacity, int? nutriKcal, String? subCategory
});




}
/// @nodoc
class _$CookItemsCopyWithImpl<$Res>
    implements $CookItemsCopyWith<$Res> {
  _$CookItemsCopyWithImpl(this._self, this._then);

  final CookItems _self;
  final $Res Function(CookItems) _then;

/// Create a copy of CookItems
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cookItemId = freezed,Object? itemId = freezed,Object? cookItemName = freezed,Object? itemName = freezed,Object? count = freezed,Object? category = freezed,Object? brandName = freezed,Object? storageArea = freezed,Object? nutriUnit = freezed,Object? nutriCapacity = freezed,Object? nutriKcal = freezed,Object? subCategory = freezed,}) {
  return _then(_self.copyWith(
cookItemId: freezed == cookItemId ? _self.cookItemId : cookItemId // ignore: cast_nullable_to_non_nullable
as int?,itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int?,cookItemName: freezed == cookItemName ? _self.cookItemName : cookItemName // ignore: cast_nullable_to_non_nullable
as String?,itemName: freezed == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,storageArea: freezed == storageArea ? _self.storageArea : storageArea // ignore: cast_nullable_to_non_nullable
as String?,nutriUnit: freezed == nutriUnit ? _self.nutriUnit : nutriUnit // ignore: cast_nullable_to_non_nullable
as String?,nutriCapacity: freezed == nutriCapacity ? _self.nutriCapacity : nutriCapacity // ignore: cast_nullable_to_non_nullable
as int?,nutriKcal: freezed == nutriKcal ? _self.nutriKcal : nutriKcal // ignore: cast_nullable_to_non_nullable
as int?,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CookItems implements CookItems {
  const _CookItems({required this.cookItemId, this.itemId, required this.cookItemName, required this.itemName, required this.count, required this.category, required this.brandName, required this.storageArea, required this.nutriUnit, required this.nutriCapacity, required this.nutriKcal, required this.subCategory});
  factory _CookItems.fromJson(Map<String, dynamic> json) => _$CookItemsFromJson(json);

@override final  int? cookItemId;
@override final  int? itemId;
@override final  String? cookItemName;
@override final  String? itemName;
@override final  int? count;
@override final  String? category;
@override final  String? brandName;
@override final  String? storageArea;
@override final  String? nutriUnit;
@override final  int? nutriCapacity;
@override final  int? nutriKcal;
@override final  String? subCategory;

/// Create a copy of CookItems
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CookItemsCopyWith<_CookItems> get copyWith => __$CookItemsCopyWithImpl<_CookItems>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CookItemsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CookItems&&(identical(other.cookItemId, cookItemId) || other.cookItemId == cookItemId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.cookItemName, cookItemName) || other.cookItemName == cookItemName)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.count, count) || other.count == count)&&(identical(other.category, category) || other.category == category)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.storageArea, storageArea) || other.storageArea == storageArea)&&(identical(other.nutriUnit, nutriUnit) || other.nutriUnit == nutriUnit)&&(identical(other.nutriCapacity, nutriCapacity) || other.nutriCapacity == nutriCapacity)&&(identical(other.nutriKcal, nutriKcal) || other.nutriKcal == nutriKcal)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cookItemId,itemId,cookItemName,itemName,count,category,brandName,storageArea,nutriUnit,nutriCapacity,nutriKcal,subCategory);

@override
String toString() {
  return 'CookItems(cookItemId: $cookItemId, itemId: $itemId, cookItemName: $cookItemName, itemName: $itemName, count: $count, category: $category, brandName: $brandName, storageArea: $storageArea, nutriUnit: $nutriUnit, nutriCapacity: $nutriCapacity, nutriKcal: $nutriKcal, subCategory: $subCategory)';
}


}

/// @nodoc
abstract mixin class _$CookItemsCopyWith<$Res> implements $CookItemsCopyWith<$Res> {
  factory _$CookItemsCopyWith(_CookItems value, $Res Function(_CookItems) _then) = __$CookItemsCopyWithImpl;
@override @useResult
$Res call({
 int? cookItemId, int? itemId, String? cookItemName, String? itemName, int? count, String? category, String? brandName, String? storageArea, String? nutriUnit, int? nutriCapacity, int? nutriKcal, String? subCategory
});




}
/// @nodoc
class __$CookItemsCopyWithImpl<$Res>
    implements _$CookItemsCopyWith<$Res> {
  __$CookItemsCopyWithImpl(this._self, this._then);

  final _CookItems _self;
  final $Res Function(_CookItems) _then;

/// Create a copy of CookItems
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cookItemId = freezed,Object? itemId = freezed,Object? cookItemName = freezed,Object? itemName = freezed,Object? count = freezed,Object? category = freezed,Object? brandName = freezed,Object? storageArea = freezed,Object? nutriUnit = freezed,Object? nutriCapacity = freezed,Object? nutriKcal = freezed,Object? subCategory = freezed,}) {
  return _then(_CookItems(
cookItemId: freezed == cookItemId ? _self.cookItemId : cookItemId // ignore: cast_nullable_to_non_nullable
as int?,itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int?,cookItemName: freezed == cookItemName ? _self.cookItemName : cookItemName // ignore: cast_nullable_to_non_nullable
as String?,itemName: freezed == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,storageArea: freezed == storageArea ? _self.storageArea : storageArea // ignore: cast_nullable_to_non_nullable
as String?,nutriUnit: freezed == nutriUnit ? _self.nutriUnit : nutriUnit // ignore: cast_nullable_to_non_nullable
as String?,nutriCapacity: freezed == nutriCapacity ? _self.nutriCapacity : nutriCapacity // ignore: cast_nullable_to_non_nullable
as int?,nutriKcal: freezed == nutriKcal ? _self.nutriKcal : nutriKcal // ignore: cast_nullable_to_non_nullable
as int?,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
