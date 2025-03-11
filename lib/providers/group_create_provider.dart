import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/state/group_state.dart';

// 그룹(냉장고) 유효성 상태관리를 위해 사용
class GroupCreateNotifier extends Notifier<GroupState> {
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

  // 그룹 생성 유효성 검사 및 업데이트
  void checkGroupName(String groupName) {
    final String trimmedName = groupName.trim(); // 공백 제거

    // 문자가 공백일 때
    if (trimmedName.isEmpty) {
      state = state.copyWith(
        groupName: trimmedName,
        errorMessage: null,
        isButton: false,
      );
      return;
    }
    
    // 특수문자 사용 여부 확인
    if (RegExp(r'[~!@#$%^&*()_+|<>?:{}]').hasMatch(groupName)) {
      state = state.copyWith(
        groupName: trimmedName,
        errorMessage: '특수문자는 사용할 수 없습니다.',
        isButton: false,
      );
      return;
    }

    // 한글과 영문만 입력 가능
    if (!RegExp(r'^[가-힣a-zA-Z\s]+$').hasMatch(trimmedName)) {
      state = state.copyWith(
        groupName: trimmedName,
        errorMessage: '한글과 영문만 입력해주세요.',
        isButton: false,
      );
      return;
    }

    // 띄어쓰기 포함 여부 확인
    if (groupName.contains(' ')) {
      state = state.copyWith(
        groupName: trimmedName,
        errorMessage: '띄어쓰기는 사용할 수 없습니다.',
        isButton: false,
      );
      return;
    }

    // 문자 길이 (2~8자)
    if (trimmedName.length < 2 || trimmedName.length > 8) {
      state = state.copyWith(
        groupName: trimmedName,
        errorMessage: '2~8자로 입력해주세요.',
        isButton: false,
      );
      return;
    }

    // 그룹 생성 정상적 입력
    state = state.copyWith(
      groupName: trimmedName,
      errorMessage: null,
      isButton: true,
    );
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
final NotifierProvider<GroupCreateNotifier, GroupState> groupCreateProvider =
    NotifierProvider<GroupCreateNotifier, GroupState>(GroupCreateNotifier.new);
