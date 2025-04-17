import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/app_logger.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/services/group_repository.dart';

class GroupNotifier extends Notifier<Group?> {
  final _groupRepository = GroupRepository();

  @override
  Group? build() => const Group(groupId: 0, groupName: '');

  // userId로 group id, name 불러오기
  Future<void> loadGroup(int userId) async {
    try {
      final Group group = await _groupRepository.loadGroup(userId);
      state = group;
    } catch (e) {
      state = null;
    }
  }

  // 해당 그룹 인원 불러오기
  Future<void> groupUserList(int userId, int groupId) async {
    try {
      final Group group = await _groupRepository.groupUserList(userId, groupId);
      state = group;
    } catch (e) {
      print(e);
      state = null;
    }
  }

  // 해당 그룹 나가기
  Future<bool> exitCurrentGroup(int userId, int groupId) async {
    try {
      await _groupRepository.exitCurrentGroup(userId, groupId);
      return true;
    } catch (e) {
      AppLogger.logger.e(e);
      return false;
    }
  }

  // 그룹 참여 승인 요청 - 거절
  Future<bool> putGroupReject(int userId, int groupId) async {
    try {
      await _groupRepository.putGroupReject(userId, groupId);
      return true;
    } catch (e) {
      AppLogger.logger.e(e);
      return false;
    }
  }

  // 그룹 참여 승인 요청 - 승인
  Future<bool> putGroupApprove(int userId, int groupId) async {
    try {
      await _groupRepository.putGroupApprove(userId, groupId);
      return true;
    } catch (e) {
      AppLogger.logger.e(e);
      return false;
    }
  }

  // 그룹원에서 그룹장은 제일 상단 위치 함수
  List<GroupUser> getSortedGroupUsers() {
    final group = state;
    if (group == null || group.groupUsers == null) return [];

    final List<GroupUser> sorted = List<GroupUser>.from(group.groupUsers!);
    sorted.sort((a, b) {
      if (a.userId == group.groupOwnerId) return -1;
      if (b.userId == group.groupOwnerId) return 1;
      return 0;
    });
    return sorted;
  }
}

final NotifierProvider<GroupNotifier, Group?> groupProvider =
    NotifierProvider<GroupNotifier, Group?>(GroupNotifier.new);
