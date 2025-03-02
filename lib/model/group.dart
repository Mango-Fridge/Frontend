class Group {
  final String groupId;
  final String groupName;
  final String groupOwner;
  final List<GroupUser>? groupUsers;

  Group({
    required this.groupId,
    required this.groupName,
    required this.groupOwner,
    this.groupUsers,
  });
}

class GroupUser {
  final String email;
  final String nickName;

  GroupUser({required this.email, required this.nickName});
}
