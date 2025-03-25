import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/state/group_state.dart';
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
      isLoadingButton: false,
    );
  }

  // 그룹id로 해당 그룹 존재 여부 확인
  void checkGroupId(String groupId) {
    final GroupRepository groupRepository = GroupRepository(); // 그룹 레포지터리 인스턴스
 
    final String trimmeGroupId = groupId.trim(); // 공백 제거

    if (_debounce?.isActive ?? false) _debounce!.cancel(); // 타이머 실행 확인, 글자 입력할 때마다 타이머 초기화
    state = state.copyWith(isLoadingButton: true); //  글자 입력 시, 버튼 로딩 표시 (설정한 타이머 기준)
    
    _debounce = Timer(const Duration(milliseconds: 600), () {
      // 문자가 공백일 때
      if (trimmeGroupId.isEmpty) {
        state = state.copyWith(
          groupId: null,
          errorMessage: null,
          isButton: false,
          isLoadingButton: false,
        );
        return;
      }

      // // 냉장고ID가 존재하지 않을 때
      // if (selectedGroup.isEmpty) {
      //   state = state.copyWith(
      //     errorMessage: '냉장고ID가 존재하지 않습니다',
      //     groupName: null,
      //     gruoupUserKing: null,
      //     groupUserCount: null,
      //     isButton: false,
      //     isLoadingButton: false,
      //   );
      //   return;
      // }

      // // 그룹 참여 정상적 입력
      // state = state.copyWith(
      //   groupId: trimmeGroupId, // 존재하는 그룹ID
      //   groupName: selectedGroup['groupName'], // 존재하는 그룹이름
      //   gruoupUserKing: selectedGroup['groupUserKing'], // 존재하는 그룹장
      //   groupUserCount: selectedGroup['groupUserCount'], // 존재하는 그룹인원 수
      //   errorMessage: null,
      //   isButton: true,
      //   isLoadingButton: false,
      // );
    });
  }

  // 그룹 생성하기, 참여하기 뷰 - 상태초기화
  void resetState() {
    state = GroupState(
      groupId: null,
      groupName: null,
      errorMessage: null,
      isButton: false,
      isLoadingButton: false,
    );
  }
}

// NotifierProvider 정의
final NotifierProvider<GroupParticipationNotifier, GroupState>
groupParticipationProvider =
    NotifierProvider<GroupParticipationNotifier, GroupState>(
      GroupParticipationNotifier.new,
    );
