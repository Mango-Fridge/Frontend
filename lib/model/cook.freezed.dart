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

 int get groupID; String get cookingName; String get cookingMemo; String get cookingNutriKcal; String get cookingNutriCarbohydrate; String get cookingNutriFat; String get cookingNutriProtein; List<Content> get cookingItems;
/// Create a copy of Cook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CookCopyWith<Cook> get copyWith => _$CookCopyWithImpl<Cook>(this as Cook, _$identity);

  /// Serializes this Cook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cook&&(identical(other.groupID, groupID) || other.groupID == groupID)&&(identical(other.cookingName, cookingName) || other.cookingName == cookingName)&&(identical(other.cookingMemo, cookingMemo) || other.cookingMemo == cookingMemo)&&(identical(other.cookingNutriKcal, cookingNutriKcal) || other.cookingNutriKcal == cookingNutriKcal)&&(identical(other.cookingNutriCarbohydrate, cookingNutriCarbohydrate) || other.cookingNutriCarbohydrate == cookingNutriCarbohydrate)&&(identical(other.cookingNutriFat, cookingNutriFat) || other.cookingNutriFat == cookingNutriFat)&&(identical(other.cookingNutriProtein, cookingNutriProtein) || other.cookingNutriProtein == cookingNutriProtein)&&const DeepCollectionEquality().equals(other.cookingItems, cookingItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupID,cookingName,cookingMemo,cookingNutriKcal,cookingNutriCarbohydrate,cookingNutriFat,cookingNutriProtein,const DeepCollectionEquality().hash(cookingItems));

@override
String toString() {
  return 'Cook(groupID: $groupID, cookingName: $cookingName, cookingMemo: $cookingMemo, cookingNutriKcal: $cookingNutriKcal, cookingNutriCarbohydrate: $cookingNutriCarbohydrate, cookingNutriFat: $cookingNutriFat, cookingNutriProtein: $cookingNutriProtein, cookingItems: $cookingItems)';
}


}

/// @nodoc
abstract mixin class $CookCopyWith<$Res>  {
  factory $CookCopyWith(Cook value, $Res Function(Cook) _then) = _$CookCopyWithImpl;
@useResult
$Res call({
 int groupID, String cookingName, String cookingMemo, String cookingNutriKcal, String cookingNutriCarbohydrate, String cookingNutriFat, String cookingNutriProtein, List<Content> cookingItems
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
@pragma('vm:prefer-inline') @override $Res call({Object? groupID = null,Object? cookingName = null,Object? cookingMemo = null,Object? cookingNutriKcal = null,Object? cookingNutriCarbohydrate = null,Object? cookingNutriFat = null,Object? cookingNutriProtein = null,Object? cookingItems = null,}) {
  return _then(_self.copyWith(
groupID: null == groupID ? _self.groupID : groupID // ignore: cast_nullable_to_non_nullable
as int,cookingName: null == cookingName ? _self.cookingName : cookingName // ignore: cast_nullable_to_non_nullable
as String,cookingMemo: null == cookingMemo ? _self.cookingMemo : cookingMemo // ignore: cast_nullable_to_non_nullable
as String,cookingNutriKcal: null == cookingNutriKcal ? _self.cookingNutriKcal : cookingNutriKcal // ignore: cast_nullable_to_non_nullable
as String,cookingNutriCarbohydrate: null == cookingNutriCarbohydrate ? _self.cookingNutriCarbohydrate : cookingNutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as String,cookingNutriFat: null == cookingNutriFat ? _self.cookingNutriFat : cookingNutriFat // ignore: cast_nullable_to_non_nullable
as String,cookingNutriProtein: null == cookingNutriProtein ? _self.cookingNutriProtein : cookingNutriProtein // ignore: cast_nullable_to_non_nullable
as String,cookingItems: null == cookingItems ? _self.cookingItems : cookingItems // ignore: cast_nullable_to_non_nullable
as List<Content>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Cook implements Cook {
  const _Cook({required this.groupID, required this.cookingName, required this.cookingMemo, required this.cookingNutriKcal, required this.cookingNutriCarbohydrate, required this.cookingNutriFat, required this.cookingNutriProtein, required final  List<Content> cookingItems}): _cookingItems = cookingItems;
  factory _Cook.fromJson(Map<String, dynamic> json) => _$CookFromJson(json);

@override final  int groupID;
@override final  String cookingName;
@override final  String cookingMemo;
@override final  String cookingNutriKcal;
@override final  String cookingNutriCarbohydrate;
@override final  String cookingNutriFat;
@override final  String cookingNutriProtein;
 final  List<Content> _cookingItems;
@override List<Content> get cookingItems {
  if (_cookingItems is EqualUnmodifiableListView) return _cookingItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cookingItems);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cook&&(identical(other.groupID, groupID) || other.groupID == groupID)&&(identical(other.cookingName, cookingName) || other.cookingName == cookingName)&&(identical(other.cookingMemo, cookingMemo) || other.cookingMemo == cookingMemo)&&(identical(other.cookingNutriKcal, cookingNutriKcal) || other.cookingNutriKcal == cookingNutriKcal)&&(identical(other.cookingNutriCarbohydrate, cookingNutriCarbohydrate) || other.cookingNutriCarbohydrate == cookingNutriCarbohydrate)&&(identical(other.cookingNutriFat, cookingNutriFat) || other.cookingNutriFat == cookingNutriFat)&&(identical(other.cookingNutriProtein, cookingNutriProtein) || other.cookingNutriProtein == cookingNutriProtein)&&const DeepCollectionEquality().equals(other._cookingItems, _cookingItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupID,cookingName,cookingMemo,cookingNutriKcal,cookingNutriCarbohydrate,cookingNutriFat,cookingNutriProtein,const DeepCollectionEquality().hash(_cookingItems));

@override
String toString() {
  return 'Cook(groupID: $groupID, cookingName: $cookingName, cookingMemo: $cookingMemo, cookingNutriKcal: $cookingNutriKcal, cookingNutriCarbohydrate: $cookingNutriCarbohydrate, cookingNutriFat: $cookingNutriFat, cookingNutriProtein: $cookingNutriProtein, cookingItems: $cookingItems)';
}


}

/// @nodoc
abstract mixin class _$CookCopyWith<$Res> implements $CookCopyWith<$Res> {
  factory _$CookCopyWith(_Cook value, $Res Function(_Cook) _then) = __$CookCopyWithImpl;
@override @useResult
$Res call({
 int groupID, String cookingName, String cookingMemo, String cookingNutriKcal, String cookingNutriCarbohydrate, String cookingNutriFat, String cookingNutriProtein, List<Content> cookingItems
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
@override @pragma('vm:prefer-inline') $Res call({Object? groupID = null,Object? cookingName = null,Object? cookingMemo = null,Object? cookingNutriKcal = null,Object? cookingNutriCarbohydrate = null,Object? cookingNutriFat = null,Object? cookingNutriProtein = null,Object? cookingItems = null,}) {
  return _then(_Cook(
groupID: null == groupID ? _self.groupID : groupID // ignore: cast_nullable_to_non_nullable
as int,cookingName: null == cookingName ? _self.cookingName : cookingName // ignore: cast_nullable_to_non_nullable
as String,cookingMemo: null == cookingMemo ? _self.cookingMemo : cookingMemo // ignore: cast_nullable_to_non_nullable
as String,cookingNutriKcal: null == cookingNutriKcal ? _self.cookingNutriKcal : cookingNutriKcal // ignore: cast_nullable_to_non_nullable
as String,cookingNutriCarbohydrate: null == cookingNutriCarbohydrate ? _self.cookingNutriCarbohydrate : cookingNutriCarbohydrate // ignore: cast_nullable_to_non_nullable
as String,cookingNutriFat: null == cookingNutriFat ? _self.cookingNutriFat : cookingNutriFat // ignore: cast_nullable_to_non_nullable
as String,cookingNutriProtein: null == cookingNutriProtein ? _self.cookingNutriProtein : cookingNutriProtein // ignore: cast_nullable_to_non_nullable
as String,cookingItems: null == cookingItems ? _self._cookingItems : cookingItems // ignore: cast_nullable_to_non_nullable
as List<Content>,
  ));
}


}

// dart format on
