import 'package:freezed_annotation/freezed_annotation.dart';
part 'group.freezed.dart';
part 'group.g.dart';

@freezed
abstract class Group with _$Group {
  const factory Group({
    required int groupId,
    required String groupCode,
    required String groupName,
    required int groupOwnerId,
    final List<GroupUser>? groupUsers,
    final List<GroupHopeUser>? groupHopeUser,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) =>
      _$GroupFromJson(json);
}

@freezed
abstract class GroupUser with _$GroupUser {
  const factory GroupUser({
    required int userId,
    required String username,
  }) = _GroupUser;

  factory GroupUser.fromJson(Map<String, dynamic> json) =>
      _$GroupUserFromJson(json);
}

@freezed
abstract class GroupHopeUser with _$GroupHopeUser {
  const factory GroupHopeUser({
    required int userId,
    required String username,
  }) = _GroupHopeUser;

  factory GroupHopeUser.fromJson(Map<String, dynamic> json) =>
      _$GroupHopeUserFromJson(json);
}
