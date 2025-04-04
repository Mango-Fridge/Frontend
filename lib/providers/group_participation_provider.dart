import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/state/group_state.dart';
import 'package:mango/services/group_repository.dart';

// 그룹(냉장고) 유효성 상태관리를 위해 사용
class GroupParticipationNotifier extends Notifier<GroupState> {
  Timer? _debounce; // 타이머 선언
  final GroupRepository groupRepository = GroupRepository();

  @override
  GroupState build() {
    // 초기 상태
    return GroupState(
      groupCode: null,
      groupName: null,
      groupOwnerName: null,
      groupMemberCount: null,
      errorMessage: null,
      isButton: false,
      isLoadingButton: false,
    );
  }

  // 그룹id로 해당 그룹 존재 여부 확인
  Future<void> isGroupValid(String groupCode) async {
    final String trimmeGroupCode = groupCode.trim(); // 공백 제거

    if (_debounce?.isActive ?? false) _debounce!.cancel(); // 타이머 실행 확인, 글자 입력할 때마다 타이머 초기화
    state = state.copyWith(isLoadingButton: true); //  글자 입력 시, 버튼 로딩 표시 (설정한 타이머 기준)
    
    _debounce = Timer(const Duration(milliseconds: 600), () async {
      // 문자가 공백일 때
      if (trimmeGroupCode.isEmpty) {
        state = state.copyWith(
          groupCode: null,
          errorMessage: null,
          isButton: false,
          isLoadingButton: false,
        );
        return;
      }

      try {
      final groupState = await groupRepository.isGroupValid(groupCode);

      state = state.copyWith(
        groupCode: groupCode,
        groupName: groupState.groupName,
        groupOwnerName: groupState.groupOwnerName,
        groupMemberCount: groupState.groupMemberCount,
        errorMessage: null,
        isButton: true,
        isLoadingButton: false,
      );
    } catch (e) {
      state = state.copyWith(
        groupCode: null,
        groupName: null,
        groupOwnerName: null,
        groupMemberCount: null,
        errorMessage: '냉장고가 존재하지 않습니다.',
        isButton: false,
        isLoadingButton: false,
      );
    }
    });
  }

  // 그룹 생성하기, 참여하기 뷰 - 상태초기화
  void resetState() {
    state = GroupState(
      groupCode: null,
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
