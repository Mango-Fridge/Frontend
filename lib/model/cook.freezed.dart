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

 int? get cookId; String? get cookName; String? get cookMemo; String? get cookNutriKcal; String? get cookNutriCarbohydrate; String? get cookNutriProtein; String? get cookNutriFat; List<CookItems>? get cookItems; int? get groupId;
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
 int? cookId, String? cookName, String? cookMemo, String? cookNutriKcal, String? cookNutriCarbohydrate, String? cookNutriProtein, String? cookNutriFat, List<CookItems>? cookItems, int? groupId
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
as String?,cookNutriCarbohydrate: freezed == cookNutriCarbohydrate ? _self.cookNutriCarbohydrate : cookNutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as String?,cookNutriProtein: freezed == cookNutriProtein ? _self.cookNutriProtein : cookNutriProtein // ignore: cast_nullable_to_non_nullable
as String?,cookNutriFat: freezed == cookNutriFat ? _self.cookNutriFat : cookNutriFat // ignore: cast_nullable_to_non_nullable
as String?,cookItems: freezed == cookItems ? _self.cookItems : cookItems // ignore: cast_nullable_to_non_nullable
as List<CookItems>?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Cook implements Cook {
  const _Cook({this.cookId, required this.cookName, required this.cookMemo, required this.cookNutriKcal, required this.cookNutriCarbohydrate, required this.cookNutriProtein, required this.cookNutriFat, final  List<CookItems>? cookItems, required this.groupId}): _cookItems = cookItems;
  factory _Cook.fromJson(Map<String, dynamic> json) => _$CookFromJson(json);

@override final  int? cookId;
@override final  String? cookName;
@override final  String? cookMemo;
@override final  String? cookNutriKcal;
@override final  String? cookNutriCarbohydrate;
@override final  String? cookNutriProtein;
@override final  String? cookNutriFat;
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
 int? cookId, String? cookName, String? cookMemo, String? cookNutriKcal, String? cookNutriCarbohydrate, String? cookNutriProtein, String? cookNutriFat, List<CookItems>? cookItems, int? groupId
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
as String?,cookNutriCarbohydrate: freezed == cookNutriCarbohydrate ? _self.cookNutriCarbohydrate : cookNutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as String?,cookNutriProtein: freezed == cookNutriProtein ? _self.cookNutriProtein : cookNutriProtein // ignore: cast_nullable_to_non_nullable
as String?,cookNutriFat: freezed == cookNutriFat ? _self.cookNutriFat : cookNutriFat // ignore: cast_nullable_to_non_nullable
as String?,cookItems: freezed == cookItems ? _self._cookItems : cookItems // ignore: cast_nullable_to_non_nullable
as List<CookItems>?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CookItems {

 int? get cookItemId; String? get cookItemName;
/// Create a copy of CookItems
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CookItemsCopyWith<CookItems> get copyWith => _$CookItemsCopyWithImpl<CookItems>(this as CookItems, _$identity);

  /// Serializes this CookItems to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CookItems&&(identical(other.cookItemId, cookItemId) || other.cookItemId == cookItemId)&&(identical(other.cookItemName, cookItemName) || other.cookItemName == cookItemName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cookItemId,cookItemName);

@override
String toString() {
  return 'CookItems(cookItemId: $cookItemId, cookItemName: $cookItemName)';
}


}

/// @nodoc
abstract mixin class $CookItemsCopyWith<$Res>  {
  factory $CookItemsCopyWith(CookItems value, $Res Function(CookItems) _then) = _$CookItemsCopyWithImpl;
@useResult
$Res call({
 int? cookItemId, String? cookItemName
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
@pragma('vm:prefer-inline') @override $Res call({Object? cookItemId = freezed,Object? cookItemName = freezed,}) {
  return _then(_self.copyWith(
cookItemId: freezed == cookItemId ? _self.cookItemId : cookItemId // ignore: cast_nullable_to_non_nullable
as int?,cookItemName: freezed == cookItemName ? _self.cookItemName : cookItemName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CookItems implements CookItems {
  const _CookItems({required this.cookItemId, required this.cookItemName});
  factory _CookItems.fromJson(Map<String, dynamic> json) => _$CookItemsFromJson(json);

@override final  int? cookItemId;
@override final  String? cookItemName;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CookItems&&(identical(other.cookItemId, cookItemId) || other.cookItemId == cookItemId)&&(identical(other.cookItemName, cookItemName) || other.cookItemName == cookItemName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cookItemId,cookItemName);

@override
String toString() {
  return 'CookItems(cookItemId: $cookItemId, cookItemName: $cookItemName)';
}


}

/// @nodoc
abstract mixin class _$CookItemsCopyWith<$Res> implements $CookItemsCopyWith<$Res> {
  factory _$CookItemsCopyWith(_CookItems value, $Res Function(_CookItems) _then) = __$CookItemsCopyWithImpl;
@override @useResult
$Res call({
 int? cookItemId, String? cookItemName
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
@override @pragma('vm:prefer-inline') $Res call({Object? cookItemId = freezed,Object? cookItemName = freezed,}) {
  return _then(_CookItems(
cookItemId: freezed == cookItemId ? _self.cookItemId : cookItemId // ignore: cast_nullable_to_non_nullable
as int?,cookItemName: freezed == cookItemName ? _self.cookItemName : cookItemName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
