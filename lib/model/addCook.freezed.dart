// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'addCook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddCook {

 int? get cookId; String? get cookName; String? get cookMemo; double? get cookNutriKcal; double? get cookNutriCarbohydrate; double? get cookNutriProtein; double? get cookNutriFat; int? get groupId; List<AddCookItem>? get cookItems;
/// Create a copy of AddCook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddCookCopyWith<AddCook> get copyWith => _$AddCookCopyWithImpl<AddCook>(this as AddCook, _$identity);

  /// Serializes this AddCook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddCook&&(identical(other.cookId, cookId) || other.cookId == cookId)&&(identical(other.cookName, cookName) || other.cookName == cookName)&&(identical(other.cookMemo, cookMemo) || other.cookMemo == cookMemo)&&(identical(other.cookNutriKcal, cookNutriKcal) || other.cookNutriKcal == cookNutriKcal)&&(identical(other.cookNutriCarbohydrate, cookNutriCarbohydrate) || other.cookNutriCarbohydrate == cookNutriCarbohydrate)&&(identical(other.cookNutriProtein, cookNutriProtein) || other.cookNutriProtein == cookNutriProtein)&&(identical(other.cookNutriFat, cookNutriFat) || other.cookNutriFat == cookNutriFat)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&const DeepCollectionEquality().equals(other.cookItems, cookItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cookId,cookName,cookMemo,cookNutriKcal,cookNutriCarbohydrate,cookNutriProtein,cookNutriFat,groupId,const DeepCollectionEquality().hash(cookItems));

@override
String toString() {
  return 'AddCook(cookId: $cookId, cookName: $cookName, cookMemo: $cookMemo, cookNutriKcal: $cookNutriKcal, cookNutriCarbohydrate: $cookNutriCarbohydrate, cookNutriProtein: $cookNutriProtein, cookNutriFat: $cookNutriFat, groupId: $groupId, cookItems: $cookItems)';
}


}

/// @nodoc
abstract mixin class $AddCookCopyWith<$Res>  {
  factory $AddCookCopyWith(AddCook value, $Res Function(AddCook) _then) = _$AddCookCopyWithImpl;
@useResult
$Res call({
 int? cookId, String? cookName, String? cookMemo, double? cookNutriKcal, double? cookNutriCarbohydrate, double? cookNutriProtein, double? cookNutriFat, int? groupId, List<AddCookItem>? cookItems
});




}
/// @nodoc
class _$AddCookCopyWithImpl<$Res>
    implements $AddCookCopyWith<$Res> {
  _$AddCookCopyWithImpl(this._self, this._then);

  final AddCook _self;
  final $Res Function(AddCook) _then;

/// Create a copy of AddCook
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cookId = freezed,Object? cookName = freezed,Object? cookMemo = freezed,Object? cookNutriKcal = freezed,Object? cookNutriCarbohydrate = freezed,Object? cookNutriProtein = freezed,Object? cookNutriFat = freezed,Object? groupId = freezed,Object? cookItems = freezed,}) {
  return _then(_self.copyWith(
cookId: freezed == cookId ? _self.cookId : cookId // ignore: cast_nullable_to_non_nullable
as int?,cookName: freezed == cookName ? _self.cookName : cookName // ignore: cast_nullable_to_non_nullable
as String?,cookMemo: freezed == cookMemo ? _self.cookMemo : cookMemo // ignore: cast_nullable_to_non_nullable
as String?,cookNutriKcal: freezed == cookNutriKcal ? _self.cookNutriKcal : cookNutriKcal // ignore: cast_nullable_to_non_nullable
as double?,cookNutriCarbohydrate: freezed == cookNutriCarbohydrate ? _self.cookNutriCarbohydrate : cookNutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as double?,cookNutriProtein: freezed == cookNutriProtein ? _self.cookNutriProtein : cookNutriProtein // ignore: cast_nullable_to_non_nullable
as double?,cookNutriFat: freezed == cookNutriFat ? _self.cookNutriFat : cookNutriFat // ignore: cast_nullable_to_non_nullable
as double?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,cookItems: freezed == cookItems ? _self.cookItems : cookItems // ignore: cast_nullable_to_non_nullable
as List<AddCookItem>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AddCook implements AddCook {
  const _AddCook({this.cookId, required this.cookName, required this.cookMemo, required this.cookNutriKcal, required this.cookNutriCarbohydrate, required this.cookNutriProtein, required this.cookNutriFat, required this.groupId, final  List<AddCookItem>? cookItems}): _cookItems = cookItems;
  factory _AddCook.fromJson(Map<String, dynamic> json) => _$AddCookFromJson(json);

@override final  int? cookId;
@override final  String? cookName;
@override final  String? cookMemo;
@override final  double? cookNutriKcal;
@override final  double? cookNutriCarbohydrate;
@override final  double? cookNutriProtein;
@override final  double? cookNutriFat;
@override final  int? groupId;
 final  List<AddCookItem>? _cookItems;
@override List<AddCookItem>? get cookItems {
  final value = _cookItems;
  if (value == null) return null;
  if (_cookItems is EqualUnmodifiableListView) return _cookItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of AddCook
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddCookCopyWith<_AddCook> get copyWith => __$AddCookCopyWithImpl<_AddCook>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddCookToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddCook&&(identical(other.cookId, cookId) || other.cookId == cookId)&&(identical(other.cookName, cookName) || other.cookName == cookName)&&(identical(other.cookMemo, cookMemo) || other.cookMemo == cookMemo)&&(identical(other.cookNutriKcal, cookNutriKcal) || other.cookNutriKcal == cookNutriKcal)&&(identical(other.cookNutriCarbohydrate, cookNutriCarbohydrate) || other.cookNutriCarbohydrate == cookNutriCarbohydrate)&&(identical(other.cookNutriProtein, cookNutriProtein) || other.cookNutriProtein == cookNutriProtein)&&(identical(other.cookNutriFat, cookNutriFat) || other.cookNutriFat == cookNutriFat)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&const DeepCollectionEquality().equals(other._cookItems, _cookItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cookId,cookName,cookMemo,cookNutriKcal,cookNutriCarbohydrate,cookNutriProtein,cookNutriFat,groupId,const DeepCollectionEquality().hash(_cookItems));

@override
String toString() {
  return 'AddCook(cookId: $cookId, cookName: $cookName, cookMemo: $cookMemo, cookNutriKcal: $cookNutriKcal, cookNutriCarbohydrate: $cookNutriCarbohydrate, cookNutriProtein: $cookNutriProtein, cookNutriFat: $cookNutriFat, groupId: $groupId, cookItems: $cookItems)';
}


}

/// @nodoc
abstract mixin class _$AddCookCopyWith<$Res> implements $AddCookCopyWith<$Res> {
  factory _$AddCookCopyWith(_AddCook value, $Res Function(_AddCook) _then) = __$AddCookCopyWithImpl;
@override @useResult
$Res call({
 int? cookId, String? cookName, String? cookMemo, double? cookNutriKcal, double? cookNutriCarbohydrate, double? cookNutriProtein, double? cookNutriFat, int? groupId, List<AddCookItem>? cookItems
});




}
/// @nodoc
class __$AddCookCopyWithImpl<$Res>
    implements _$AddCookCopyWith<$Res> {
  __$AddCookCopyWithImpl(this._self, this._then);

  final _AddCook _self;
  final $Res Function(_AddCook) _then;

/// Create a copy of AddCook
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cookId = freezed,Object? cookName = freezed,Object? cookMemo = freezed,Object? cookNutriKcal = freezed,Object? cookNutriCarbohydrate = freezed,Object? cookNutriProtein = freezed,Object? cookNutriFat = freezed,Object? groupId = freezed,Object? cookItems = freezed,}) {
  return _then(_AddCook(
cookId: freezed == cookId ? _self.cookId : cookId // ignore: cast_nullable_to_non_nullable
as int?,cookName: freezed == cookName ? _self.cookName : cookName // ignore: cast_nullable_to_non_nullable
as String?,cookMemo: freezed == cookMemo ? _self.cookMemo : cookMemo // ignore: cast_nullable_to_non_nullable
as String?,cookNutriKcal: freezed == cookNutriKcal ? _self.cookNutriKcal : cookNutriKcal // ignore: cast_nullable_to_non_nullable
as double?,cookNutriCarbohydrate: freezed == cookNutriCarbohydrate ? _self.cookNutriCarbohydrate : cookNutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as double?,cookNutriProtein: freezed == cookNutriProtein ? _self.cookNutriProtein : cookNutriProtein // ignore: cast_nullable_to_non_nullable
as double?,cookNutriFat: freezed == cookNutriFat ? _self.cookNutriFat : cookNutriFat // ignore: cast_nullable_to_non_nullable
as double?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,cookItems: freezed == cookItems ? _self._cookItems : cookItems // ignore: cast_nullable_to_non_nullable
as List<AddCookItem>?,
  ));
}


}


/// @nodoc
mixin _$AddCookItem {

 String? get itemName; int? get count; String? get category; String? get brandName; String? get storageArea; String? get nutriUnit; double? get nutriCapacity; double? get nutriKcal;
/// Create a copy of AddCookItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddCookItemCopyWith<AddCookItem> get copyWith => _$AddCookItemCopyWithImpl<AddCookItem>(this as AddCookItem, _$identity);

  /// Serializes this AddCookItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddCookItem&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.count, count) || other.count == count)&&(identical(other.category, category) || other.category == category)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.storageArea, storageArea) || other.storageArea == storageArea)&&(identical(other.nutriUnit, nutriUnit) || other.nutriUnit == nutriUnit)&&(identical(other.nutriCapacity, nutriCapacity) || other.nutriCapacity == nutriCapacity)&&(identical(other.nutriKcal, nutriKcal) || other.nutriKcal == nutriKcal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemName,count,category,brandName,storageArea,nutriUnit,nutriCapacity,nutriKcal);

@override
String toString() {
  return 'AddCookItem(itemName: $itemName, count: $count, category: $category, brandName: $brandName, storageArea: $storageArea, nutriUnit: $nutriUnit, nutriCapacity: $nutriCapacity, nutriKcal: $nutriKcal)';
}


}

/// @nodoc
abstract mixin class $AddCookItemCopyWith<$Res>  {
  factory $AddCookItemCopyWith(AddCookItem value, $Res Function(AddCookItem) _then) = _$AddCookItemCopyWithImpl;
@useResult
$Res call({
 String? itemName, int? count, String? category, String? brandName, String? storageArea, String? nutriUnit, double? nutriCapacity, double? nutriKcal
});




}
/// @nodoc
class _$AddCookItemCopyWithImpl<$Res>
    implements $AddCookItemCopyWith<$Res> {
  _$AddCookItemCopyWithImpl(this._self, this._then);

  final AddCookItem _self;
  final $Res Function(AddCookItem) _then;

/// Create a copy of AddCookItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemName = freezed,Object? count = freezed,Object? category = freezed,Object? brandName = freezed,Object? storageArea = freezed,Object? nutriUnit = freezed,Object? nutriCapacity = freezed,Object? nutriKcal = freezed,}) {
  return _then(_self.copyWith(
itemName: freezed == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,storageArea: freezed == storageArea ? _self.storageArea : storageArea // ignore: cast_nullable_to_non_nullable
as String?,nutriUnit: freezed == nutriUnit ? _self.nutriUnit : nutriUnit // ignore: cast_nullable_to_non_nullable
as String?,nutriCapacity: freezed == nutriCapacity ? _self.nutriCapacity : nutriCapacity // ignore: cast_nullable_to_non_nullable
as double?,nutriKcal: freezed == nutriKcal ? _self.nutriKcal : nutriKcal // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AddCookItem implements AddCookItem {
  const _AddCookItem({required this.itemName, required this.count, required this.category, required this.brandName, required this.storageArea, required this.nutriUnit, required this.nutriCapacity, required this.nutriKcal});
  factory _AddCookItem.fromJson(Map<String, dynamic> json) => _$AddCookItemFromJson(json);

@override final  String? itemName;
@override final  int? count;
@override final  String? category;
@override final  String? brandName;
@override final  String? storageArea;
@override final  String? nutriUnit;
@override final  double? nutriCapacity;
@override final  double? nutriKcal;

/// Create a copy of AddCookItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddCookItemCopyWith<_AddCookItem> get copyWith => __$AddCookItemCopyWithImpl<_AddCookItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddCookItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddCookItem&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.count, count) || other.count == count)&&(identical(other.category, category) || other.category == category)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.storageArea, storageArea) || other.storageArea == storageArea)&&(identical(other.nutriUnit, nutriUnit) || other.nutriUnit == nutriUnit)&&(identical(other.nutriCapacity, nutriCapacity) || other.nutriCapacity == nutriCapacity)&&(identical(other.nutriKcal, nutriKcal) || other.nutriKcal == nutriKcal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemName,count,category,brandName,storageArea,nutriUnit,nutriCapacity,nutriKcal);

@override
String toString() {
  return 'AddCookItem(itemName: $itemName, count: $count, category: $category, brandName: $brandName, storageArea: $storageArea, nutriUnit: $nutriUnit, nutriCapacity: $nutriCapacity, nutriKcal: $nutriKcal)';
}


}

/// @nodoc
abstract mixin class _$AddCookItemCopyWith<$Res> implements $AddCookItemCopyWith<$Res> {
  factory _$AddCookItemCopyWith(_AddCookItem value, $Res Function(_AddCookItem) _then) = __$AddCookItemCopyWithImpl;
@override @useResult
$Res call({
 String? itemName, int? count, String? category, String? brandName, String? storageArea, String? nutriUnit, double? nutriCapacity, double? nutriKcal
});




}
/// @nodoc
class __$AddCookItemCopyWithImpl<$Res>
    implements _$AddCookItemCopyWith<$Res> {
  __$AddCookItemCopyWithImpl(this._self, this._then);

  final _AddCookItem _self;
  final $Res Function(_AddCookItem) _then;

/// Create a copy of AddCookItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemName = freezed,Object? count = freezed,Object? category = freezed,Object? brandName = freezed,Object? storageArea = freezed,Object? nutriUnit = freezed,Object? nutriCapacity = freezed,Object? nutriKcal = freezed,}) {
  return _then(_AddCookItem(
itemName: freezed == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,storageArea: freezed == storageArea ? _self.storageArea : storageArea // ignore: cast_nullable_to_non_nullable
as String?,nutriUnit: freezed == nutriUnit ? _self.nutriUnit : nutriUnit // ignore: cast_nullable_to_non_nullable
as String?,nutriCapacity: freezed == nutriCapacity ? _self.nutriCapacity : nutriCapacity // ignore: cast_nullable_to_non_nullable
as double?,nutriKcal: freezed == nutriKcal ? _self.nutriKcal : nutriKcal // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
