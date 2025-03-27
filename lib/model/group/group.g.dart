// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Group _$GroupFromJson(Map<String, dynamic> json) => _Group(
  groupId: (json['groupId'] as num).toInt(),
  groupCode: json['groupCode'] as String?,
  groupName: json['groupName'] as String,
  groupOwnerId: (json['groupOwnerId'] as num?)?.toInt(),
  groupUsers:
      (json['groupUsers'] as List<dynamic>?)
          ?.map((e) => GroupUser.fromJson(e as Map<String, dynamic>))
          .toList(),
  groupHopeUser:
      (json['groupHopeUser'] as List<dynamic>?)
          ?.map((e) => GroupHopeUser.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GroupToJson(_Group instance) => <String, dynamic>{
  'groupId': instance.groupId,
  'groupCode': instance.groupCode,
  'groupName': instance.groupName,
  'groupOwnerId': instance.groupOwnerId,
  'groupUsers': instance.groupUsers,
  'groupHopeUser': instance.groupHopeUser,
};

_GroupUser _$GroupUserFromJson(Map<String, dynamic> json) => _GroupUser(
  userId: (json['userId'] as num).toInt(),
  username: json['username'] as String,
);

Map<String, dynamic> _$GroupUserToJson(_GroupUser instance) =>
    <String, dynamic>{'userId': instance.userId, 'username': instance.username};

_GroupHopeUser _$GroupHopeUserFromJson(Map<String, dynamic> json) =>
    _GroupHopeUser(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
    );

Map<String, dynamic> _$GroupHopeUserToJson(_GroupHopeUser instance) =>
    <String, dynamic>{'userId': instance.userId, 'username': instance.username};
