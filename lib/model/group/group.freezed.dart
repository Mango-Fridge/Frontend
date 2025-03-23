// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Group {

 int get groupId; String get groupCode; String get groupName; int get groupOwnerId; List<GroupUser>? get groupUsers; List<GroupHopeUser>? get groupHopeUser;
/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupCopyWith<Group> get copyWith => _$GroupCopyWithImpl<Group>(this as Group, _$identity);

  /// Serializes this Group to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Group&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupCode, groupCode) || other.groupCode == groupCode)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.groupOwnerId, groupOwnerId) || other.groupOwnerId == groupOwnerId)&&const DeepCollectionEquality().equals(other.groupUsers, groupUsers)&&const DeepCollectionEquality().equals(other.groupHopeUser, groupHopeUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupId,groupCode,groupName,groupOwnerId,const DeepCollectionEquality().hash(groupUsers),const DeepCollectionEquality().hash(groupHopeUser));

@override
String toString() {
  return 'Group(groupId: $groupId, groupCode: $groupCode, groupName: $groupName, groupOwnerId: $groupOwnerId, groupUsers: $groupUsers, groupHopeUser: $groupHopeUser)';
}


}

/// @nodoc
abstract mixin class $GroupCopyWith<$Res>  {
  factory $GroupCopyWith(Group value, $Res Function(Group) _then) = _$GroupCopyWithImpl;
@useResult
$Res call({
 int groupId, String groupCode, String groupName, int groupOwnerId, List<GroupUser>? groupUsers, List<GroupHopeUser>? groupHopeUser
});




}
/// @nodoc
class _$GroupCopyWithImpl<$Res>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._self, this._then);

  final Group _self;
  final $Res Function(Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupId = null,Object? groupCode = null,Object? groupName = null,Object? groupOwnerId = null,Object? groupUsers = freezed,Object? groupHopeUser = freezed,}) {
  return _then(_self.copyWith(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,groupCode: null == groupCode ? _self.groupCode : groupCode // ignore: cast_nullable_to_non_nullable
as String,groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,groupOwnerId: null == groupOwnerId ? _self.groupOwnerId : groupOwnerId // ignore: cast_nullable_to_non_nullable
as int,groupUsers: freezed == groupUsers ? _self.groupUsers : groupUsers // ignore: cast_nullable_to_non_nullable
as List<GroupUser>?,groupHopeUser: freezed == groupHopeUser ? _self.groupHopeUser : groupHopeUser // ignore: cast_nullable_to_non_nullable
as List<GroupHopeUser>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Group implements Group {
  const _Group({required this.groupId, required this.groupCode, required this.groupName, required this.groupOwnerId, final  List<GroupUser>? groupUsers, final  List<GroupHopeUser>? groupHopeUser}): _groupUsers = groupUsers,_groupHopeUser = groupHopeUser;
  factory _Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

@override final  int groupId;
@override final  String groupCode;
@override final  String groupName;
@override final  int groupOwnerId;
 final  List<GroupUser>? _groupUsers;
@override List<GroupUser>? get groupUsers {
  final value = _groupUsers;
  if (value == null) return null;
  if (_groupUsers is EqualUnmodifiableListView) return _groupUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<GroupHopeUser>? _groupHopeUser;
@override List<GroupHopeUser>? get groupHopeUser {
  final value = _groupHopeUser;
  if (value == null) return null;
  if (_groupHopeUser is EqualUnmodifiableListView) return _groupHopeUser;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupCopyWith<_Group> get copyWith => __$GroupCopyWithImpl<_Group>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Group&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupCode, groupCode) || other.groupCode == groupCode)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.groupOwnerId, groupOwnerId) || other.groupOwnerId == groupOwnerId)&&const DeepCollectionEquality().equals(other._groupUsers, _groupUsers)&&const DeepCollectionEquality().equals(other._groupHopeUser, _groupHopeUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupId,groupCode,groupName,groupOwnerId,const DeepCollectionEquality().hash(_groupUsers),const DeepCollectionEquality().hash(_groupHopeUser));

@override
String toString() {
  return 'Group(groupId: $groupId, groupCode: $groupCode, groupName: $groupName, groupOwnerId: $groupOwnerId, groupUsers: $groupUsers, groupHopeUser: $groupHopeUser)';
}


}

/// @nodoc
abstract mixin class _$GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$GroupCopyWith(_Group value, $Res Function(_Group) _then) = __$GroupCopyWithImpl;
@override @useResult
$Res call({
 int groupId, String groupCode, String groupName, int groupOwnerId, List<GroupUser>? groupUsers, List<GroupHopeUser>? groupHopeUser
});




}
/// @nodoc
class __$GroupCopyWithImpl<$Res>
    implements _$GroupCopyWith<$Res> {
  __$GroupCopyWithImpl(this._self, this._then);

  final _Group _self;
  final $Res Function(_Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? groupCode = null,Object? groupName = null,Object? groupOwnerId = null,Object? groupUsers = freezed,Object? groupHopeUser = freezed,}) {
  return _then(_Group(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,groupCode: null == groupCode ? _self.groupCode : groupCode // ignore: cast_nullable_to_non_nullable
as String,groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,groupOwnerId: null == groupOwnerId ? _self.groupOwnerId : groupOwnerId // ignore: cast_nullable_to_non_nullable
as int,groupUsers: freezed == groupUsers ? _self._groupUsers : groupUsers // ignore: cast_nullable_to_non_nullable
as List<GroupUser>?,groupHopeUser: freezed == groupHopeUser ? _self._groupHopeUser : groupHopeUser // ignore: cast_nullable_to_non_nullable
as List<GroupHopeUser>?,
  ));
}


}


/// @nodoc
mixin _$GroupUser {

 int get userId; String get username;
/// Create a copy of GroupUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupUserCopyWith<GroupUser> get copyWith => _$GroupUserCopyWithImpl<GroupUser>(this as GroupUser, _$identity);

  /// Serializes this GroupUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username);

@override
String toString() {
  return 'GroupUser(userId: $userId, username: $username)';
}


}

/// @nodoc
abstract mixin class $GroupUserCopyWith<$Res>  {
  factory $GroupUserCopyWith(GroupUser value, $Res Function(GroupUser) _then) = _$GroupUserCopyWithImpl;
@useResult
$Res call({
 int userId, String username
});




}
/// @nodoc
class _$GroupUserCopyWithImpl<$Res>
    implements $GroupUserCopyWith<$Res> {
  _$GroupUserCopyWithImpl(this._self, this._then);

  final GroupUser _self;
  final $Res Function(GroupUser) _then;

/// Create a copy of GroupUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? username = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _GroupUser implements GroupUser {
  const _GroupUser({required this.userId, required this.username});
  factory _GroupUser.fromJson(Map<String, dynamic> json) => _$GroupUserFromJson(json);

@override final  int userId;
@override final  String username;

/// Create a copy of GroupUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupUserCopyWith<_GroupUser> get copyWith => __$GroupUserCopyWithImpl<_GroupUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username);

@override
String toString() {
  return 'GroupUser(userId: $userId, username: $username)';
}


}

/// @nodoc
abstract mixin class _$GroupUserCopyWith<$Res> implements $GroupUserCopyWith<$Res> {
  factory _$GroupUserCopyWith(_GroupUser value, $Res Function(_GroupUser) _then) = __$GroupUserCopyWithImpl;
@override @useResult
$Res call({
 int userId, String username
});




}
/// @nodoc
class __$GroupUserCopyWithImpl<$Res>
    implements _$GroupUserCopyWith<$Res> {
  __$GroupUserCopyWithImpl(this._self, this._then);

  final _GroupUser _self;
  final $Res Function(_GroupUser) _then;

/// Create a copy of GroupUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,}) {
  return _then(_GroupUser(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GroupHopeUser {

 int get userId; String get username;
/// Create a copy of GroupHopeUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupHopeUserCopyWith<GroupHopeUser> get copyWith => _$GroupHopeUserCopyWithImpl<GroupHopeUser>(this as GroupHopeUser, _$identity);

  /// Serializes this GroupHopeUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupHopeUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username);

@override
String toString() {
  return 'GroupHopeUser(userId: $userId, username: $username)';
}


}

/// @nodoc
abstract mixin class $GroupHopeUserCopyWith<$Res>  {
  factory $GroupHopeUserCopyWith(GroupHopeUser value, $Res Function(GroupHopeUser) _then) = _$GroupHopeUserCopyWithImpl;
@useResult
$Res call({
 int userId, String username
});




}
/// @nodoc
class _$GroupHopeUserCopyWithImpl<$Res>
    implements $GroupHopeUserCopyWith<$Res> {
  _$GroupHopeUserCopyWithImpl(this._self, this._then);

  final GroupHopeUser _self;
  final $Res Function(GroupHopeUser) _then;

/// Create a copy of GroupHopeUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? username = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _GroupHopeUser implements GroupHopeUser {
  const _GroupHopeUser({required this.userId, required this.username});
  factory _GroupHopeUser.fromJson(Map<String, dynamic> json) => _$GroupHopeUserFromJson(json);

@override final  int userId;
@override final  String username;

/// Create a copy of GroupHopeUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupHopeUserCopyWith<_GroupHopeUser> get copyWith => __$GroupHopeUserCopyWithImpl<_GroupHopeUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupHopeUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupHopeUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username);

@override
String toString() {
  return 'GroupHopeUser(userId: $userId, username: $username)';
}


}

/// @nodoc
abstract mixin class _$GroupHopeUserCopyWith<$Res> implements $GroupHopeUserCopyWith<$Res> {
  factory _$GroupHopeUserCopyWith(_GroupHopeUser value, $Res Function(_GroupHopeUser) _then) = __$GroupHopeUserCopyWithImpl;
@override @useResult
$Res call({
 int userId, String username
});




}
/// @nodoc
class __$GroupHopeUserCopyWithImpl<$Res>
    implements _$GroupHopeUserCopyWith<$Res> {
  __$GroupHopeUserCopyWithImpl(this._self, this._then);

  final _GroupHopeUser _self;
  final $Res Function(_GroupHopeUser) _then;

/// Create a copy of GroupHopeUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,}) {
  return _then(_GroupHopeUser(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
