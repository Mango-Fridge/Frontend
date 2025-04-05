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
}

final NotifierProvider<GroupNotifier, Group?> groupProvider =
    NotifierProvider<GroupNotifier, Group?>(GroupNotifier.new);

// email에 의해 불려온 group List 관리
// 그룹에 의해 불려온 content List 관리

// 물품 + 개수 상태 관리
// 물품 - 개수 상태 관리

// 승인대기요청 그룹 이름 프로바이더 - 통신 시작하면 바뀔 수 있음
final groupRequestProvider = StateProvider<String>((ref) => '');
