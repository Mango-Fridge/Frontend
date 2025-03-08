import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/group_state.dart';
import 'package:mango/services/group_repository.dart';

// 그룹(냉장고) 유효성 상태관리를 위해 사용
class GroupParticipationNotifier extends Notifier<GroupState> {
  Timer? _debounce; // 타이머 선언

  @override
  GroupState build() {
    // 초기 상태
    return GroupState(
      groupId: null,
      groupName: null,
      gruoupUserKing: null,
      groupUserCount: null,
      errorMessage: null,
      isButton: false,
    );
  }

  // 그룹id로 해당 그룹 존재 여부 확인
  void checkGroupId(String groupId) {
    final GroupRepository groupRepository = GroupRepository(); // 그룹 레포지터리 인스턴스

    // 공백 제거
    final String trimmeGroupId = groupId.trim();

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      // 문자가 공백일 때
      if (trimmeGroupId.isEmpty) {
        state = state.copyWith(
          groupId: null,
          errorMessage: null,
          isButton: false,
        );
        return;
      }

      // 그룹 ID가 존재하는 지 확인 후, 데이터 담기
      final Map<String, dynamic> selectedGroup = groupRepository.dummyGroups.firstWhere(
        (group) => group['groupId'] == trimmeGroupId,
        orElse: () => <String, dynamic>{}, // 없다면 빈값으로 반환
      );

      // 냉장고ID가 존재하지 않을 때
      if (selectedGroup.isEmpty) {
        state = state.copyWith(
          errorMessage: '냉장고ID가 존재하지 않습니다',
          isButton: false,
        );
      } else {
        // 그룹 참여 정상적 입력
        state = state.copyWith(
          groupId: trimmeGroupId, // 존재하는 그룹ID
          groupName: selectedGroup['groupName'], // 존재하는 그룹이름
          gruoupUserKing: selectedGroup['groupUserKing'],
          groupUserCount: selectedGroup['groupUserCount'],
          errorMessage: null,
          isButton: true,
        );
      }
    });
  }

  // 그룹 생성하기, 참여하기 뷰 - 상태초기화
  void resetState() {
    state = GroupState(
      groupId: null,
      groupName: null,
      errorMessage: null,
      isButton: false,
    );
  }
}

// NotifierProvider 정의
final NotifierProvider<GroupParticipationNotifier, GroupState> groupParticipationProvider =
    NotifierProvider<GroupParticipationNotifier, GroupState>(GroupParticipationNotifier.new);
