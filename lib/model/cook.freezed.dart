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

 int get groupID; int get cookID; String get cookName; String get cookMemo; String get cookNutriKcal; String get cookNutriCarbohydrate; String get cookingNutriFat; String get cookNutriProtein; List<Content> get cookItems;
/// Create a copy of Cook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CookCopyWith<Cook> get copyWith => _$CookCopyWithImpl<Cook>(this as Cook, _$identity);

  /// Serializes this Cook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cook&&(identical(other.groupID, groupID) || other.groupID == groupID)&&(identical(other.cookID, cookID) || other.cookID == cookID)&&(identical(other.cookName, cookName) || other.cookName == cookName)&&(identical(other.cookMemo, cookMemo) || other.cookMemo == cookMemo)&&(identical(other.cookNutriKcal, cookNutriKcal) || other.cookNutriKcal == cookNutriKcal)&&(identical(other.cookNutriCarbohydrate, cookNutriCarbohydrate) || other.cookNutriCarbohydrate == cookNutriCarbohydrate)&&(identical(other.cookingNutriFat, cookingNutriFat) || other.cookingNutriFat == cookingNutriFat)&&(identical(other.cookNutriProtein, cookNutriProtein) || other.cookNutriProtein == cookNutriProtein)&&const DeepCollectionEquality().equals(other.cookItems, cookItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupID,cookID,cookName,cookMemo,cookNutriKcal,cookNutriCarbohydrate,cookingNutriFat,cookNutriProtein,const DeepCollectionEquality().hash(cookItems));

@override
String toString() {
  return 'Cook(groupID: $groupID, cookID: $cookID, cookName: $cookName, cookMemo: $cookMemo, cookNutriKcal: $cookNutriKcal, cookNutriCarbohydrate: $cookNutriCarbohydrate, cookingNutriFat: $cookingNutriFat, cookNutriProtein: $cookNutriProtein, cookItems: $cookItems)';
}


}

/// @nodoc
abstract mixin class $CookCopyWith<$Res>  {
  factory $CookCopyWith(Cook value, $Res Function(Cook) _then) = _$CookCopyWithImpl;
@useResult
$Res call({
 int groupID, int cookID, String cookName, String cookMemo, String cookNutriKcal, String cookNutriCarbohydrate, String cookingNutriFat, String cookNutriProtein, List<Content> cookItems
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
@pragma('vm:prefer-inline') @override $Res call({Object? groupID = null,Object? cookID = null,Object? cookName = null,Object? cookMemo = null,Object? cookNutriKcal = null,Object? cookNutriCarbohydrate = null,Object? cookingNutriFat = null,Object? cookNutriProtein = null,Object? cookItems = null,}) {
  return _then(_self.copyWith(
groupID: null == groupID ? _self.groupID : groupID // ignore: cast_nullable_to_non_nullable
as int,cookID: null == cookID ? _self.cookID : cookID // ignore: cast_nullable_to_non_nullable
as int,cookName: null == cookName ? _self.cookName : cookName // ignore: cast_nullable_to_non_nullable
as String,cookMemo: null == cookMemo ? _self.cookMemo : cookMemo // ignore: cast_nullable_to_non_nullable
as String,cookNutriKcal: null == cookNutriKcal ? _self.cookNutriKcal : cookNutriKcal // ignore: cast_nullable_to_non_nullable
as String,cookNutriCarbohydrate: null == cookNutriCarbohydrate ? _self.cookNutriCarbohydrate : cookNutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as String,cookingNutriFat: null == cookingNutriFat ? _self.cookingNutriFat : cookingNutriFat // ignore: cast_nullable_to_non_nullable
as String,cookNutriProtein: null == cookNutriProtein ? _self.cookNutriProtein : cookNutriProtein // ignore: cast_nullable_to_non_nullable
as String,cookItems: null == cookItems ? _self.cookItems : cookItems // ignore: cast_nullable_to_non_nullable
as List<Content>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Cook implements Cook {
  const _Cook({required this.groupID, required this.cookID, required this.cookName, required this.cookMemo, required this.cookNutriKcal, required this.cookNutriCarbohydrate, required this.cookingNutriFat, required this.cookNutriProtein, required final  List<Content> cookItems}): _cookItems = cookItems;
  factory _Cook.fromJson(Map<String, dynamic> json) => _$CookFromJson(json);

@override final  int groupID;
@override final  int cookID;
@override final  String cookName;
@override final  String cookMemo;
@override final  String cookNutriKcal;
@override final  String cookNutriCarbohydrate;
@override final  String cookingNutriFat;
@override final  String cookNutriProtein;
 final  List<Content> _cookItems;
@override List<Content> get cookItems {
  if (_cookItems is EqualUnmodifiableListView) return _cookItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cookItems);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cook&&(identical(other.groupID, groupID) || other.groupID == groupID)&&(identical(other.cookID, cookID) || other.cookID == cookID)&&(identical(other.cookName, cookName) || other.cookName == cookName)&&(identical(other.cookMemo, cookMemo) || other.cookMemo == cookMemo)&&(identical(other.cookNutriKcal, cookNutriKcal) || other.cookNutriKcal == cookNutriKcal)&&(identical(other.cookNutriCarbohydrate, cookNutriCarbohydrate) || other.cookNutriCarbohydrate == cookNutriCarbohydrate)&&(identical(other.cookingNutriFat, cookingNutriFat) || other.cookingNutriFat == cookingNutriFat)&&(identical(other.cookNutriProtein, cookNutriProtein) || other.cookNutriProtein == cookNutriProtein)&&const DeepCollectionEquality().equals(other._cookItems, _cookItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupID,cookID,cookName,cookMemo,cookNutriKcal,cookNutriCarbohydrate,cookingNutriFat,cookNutriProtein,const DeepCollectionEquality().hash(_cookItems));

@override
String toString() {
  return 'Cook(groupID: $groupID, cookID: $cookID, cookName: $cookName, cookMemo: $cookMemo, cookNutriKcal: $cookNutriKcal, cookNutriCarbohydrate: $cookNutriCarbohydrate, cookingNutriFat: $cookingNutriFat, cookNutriProtein: $cookNutriProtein, cookItems: $cookItems)';
}


}

/// @nodoc
abstract mixin class _$CookCopyWith<$Res> implements $CookCopyWith<$Res> {
  factory _$CookCopyWith(_Cook value, $Res Function(_Cook) _then) = __$CookCopyWithImpl;
@override @useResult
$Res call({
 int groupID, int cookID, String cookName, String cookMemo, String cookNutriKcal, String cookNutriCarbohydrate, String cookingNutriFat, String cookNutriProtein, List<Content> cookItems
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
@override @pragma('vm:prefer-inline') $Res call({Object? groupID = null,Object? cookID = null,Object? cookName = null,Object? cookMemo = null,Object? cookNutriKcal = null,Object? cookNutriCarbohydrate = null,Object? cookingNutriFat = null,Object? cookNutriProtein = null,Object? cookItems = null,}) {
  return _then(_Cook(
groupID: null == groupID ? _self.groupID : groupID // ignore: cast_nullable_to_non_nullable
as int,cookID: null == cookID ? _self.cookID : cookID // ignore: cast_nullable_to_non_nullable
as int,cookName: null == cookName ? _self.cookName : cookName // ignore: cast_nullable_to_non_nullable
as String,cookMemo: null == cookMemo ? _self.cookMemo : cookMemo // ignore: cast_nullable_to_non_nullable
as String,cookNutriKcal: null == cookNutriKcal ? _self.cookNutriKcal : cookNutriKcal // ignore: cast_nullable_to_non_nullable
as String,cookNutriCarbohydrate: null == cookNutriCarbohydrate ? _self.cookNutriCarbohydrate : cookNutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as String,cookingNutriFat: null == cookingNutriFat ? _self.cookingNutriFat : cookingNutriFat // ignore: cast_nullable_to_non_nullable
as String,cookNutriProtein: null == cookNutriProtein ? _self.cookNutriProtein : cookNutriProtein // ignore: cast_nullable_to_non_nullable
as String,cookItems: null == cookItems ? _self._cookItems : cookItems // ignore: cast_nullable_to_non_nullable
as List<Content>,
  ));
}


}

// dart format on
