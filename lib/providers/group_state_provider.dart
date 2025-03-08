import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/group_modal_view_state.dart';
import 'package:mango/model/group_state.dart';

// 그룹(냉장고) 유효성 상태관리를 위해 사용
class GroupStateNotifier extends Notifier<GroupState> {
  Timer? _debounce; // 타이머 선언

  @override
  GroupState build() {
    // 초기 상태
    return GroupState(
      groupName: '',
      groupId: '',
      errorMessage: null,
      isButton: false,
    );
  }

  // 그룹 생성 유효성 검사 및 업데이트
  void checkGroupName(String groupName) {
    final trimmedName = groupName.trim(); // 공백 제거

    // 새로운 입력이 발생할 때마다 이전 타이머를 취소하는 역할
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    // 타이머 시작
    _debounce = Timer(const Duration(milliseconds: 600), () {
      // 문자가 공백일 때
      if (trimmedName.isEmpty) {
        state = state.copyWith(
          groupName: trimmedName,
          errorMessage: null,
          isButton: false,
        );
        return;
      }
      if (RegExp(r'[~!@#$%^&*()_+|<>?:{}]').hasMatch(groupName)) {
        // 특수문자 사용 여부 확인
        state = state.copyWith(
          groupName: trimmedName,
          errorMessage: "특수문자는 사용할 수 없습니다.",
          isButton: false,
        );
        return;
      } else if (!RegExp(r'^[가-힣a-zA-Z\s]+$').hasMatch(trimmedName)) {
        // 한글과 영문만 입력 가능
        state = state.copyWith(
          groupName: trimmedName,
          errorMessage: "한글과 영문만 입력해주세요.",
          isButton: false,
        );
        return;
      } else if (groupName.contains(' ')) {
        // 띄어쓰기 포함 여부 확인
        state = state.copyWith(
          groupName: trimmedName,
          errorMessage: "띄어쓰기는 사용할 수 없습니다.",
          isButton: false,
        );
        return;
      } else if (trimmedName.length < 2 || trimmedName.length > 8) {
        // 문자 길이 (2~8자)
        state = state.copyWith(
          groupName: trimmedName,
          errorMessage: "2~8자로 입력해주세요.",
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
    });
  }

  // 테스트: 참여하기 모달 뷰 - 타이머를 활용해서, 1.5초 뒤에 print
  void checkGroupParticipation(String groupId) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      // 공백 제거
      final trimmeGroupId = groupId.trim();

      // 문자가 공백일 때
      if (trimmeGroupId.isEmpty) {
        state = state.copyWith(
          groupName: trimmeGroupId,
          errorMessage: null,
          isButton: false,
        );
        return;
      } else if (!RegExp(r'^[가-힣a-zA-Z\s]+$').hasMatch(trimmeGroupId)) {
        state = state.copyWith(
          groupName: trimmeGroupId,
          errorMessage: "한글과 영문만 입력해주세요.",
          isButton: false,
        );
        return;
      }
      print(groupId);

      // 그룹 참여 정상적 입력
      state = state.copyWith(
        groupId: trimmeGroupId,
        errorMessage: null,
        isButton: true,
      );
    });
  }

  // 그룹 생성하기 뷰로 갈 시, 상태초기화
  void resetState() {
    state = GroupState(
      groupName: '',
      groupId: '',
      errorMessage: null,
      isButton: false,
    );
  }
}

// NotifierProvider 정의
final groupStateProvider = NotifierProvider<GroupStateNotifier, GroupState>(
  GroupStateNotifier.new,
);

// 모달 화면 상태 관리
final groupModalStateProvider = StateProvider<GroupModalViewState>((ref) {
  return GroupModalViewState.start; // 초기 값 - 그룹 '시작하기' 뷰
});