import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/services/group_repository.dart';
import 'package:mango/state/group_state.dart';

// 그룹(냉장고) 생성 상태관리를 위해 사용
class GroupCreateNotifier extends Notifier<GroupState> {
  final GroupRepository groupRepository = GroupRepository();
  Timer? _debounce; // 타이머 선언

  @override
  GroupState build() {
    // 초기 상태
    return GroupState(
      groupId: null,
      groupName: null,
      groupOwnerName: null,
      groupMemberCount: null,
      errorMessage: null,
      isButton: false,
      isLoadingButton: false,
    );
  }

  // 그룹 생성 API 호출
  Future<bool> createGroup(int userId, String groupName) async {
    try {
      await groupRepository.createGroup(userId, groupName);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: '$e', isButton: false, isLoadingButton: false);
      return false;
    } 
  }

  // 그룹 생성 유효성 검사 및 업데이트
  void checkGroupName(String groupName) {
    final String trimmedName = groupName.trim(); // 공백 제거

    if (_debounce?.isActive ?? false)
      _debounce!.cancel(); // 타이머 실행 확인, 글자 입력할 때마다 타이머 초기화
    state = state.copyWith(
      isLoadingButton: true,
    ); //  글자 입력 시, 버튼 로딩 표시 (설정한 타이머 기준)

    _debounce = Timer(const Duration(milliseconds: 600), () {
      // 문자가 공백일 때
      if (trimmedName.isEmpty) {
        state = state.copyWith(
          groupName: trimmedName,
          errorMessage: null,
          isButton: false,
          isLoadingButton: false,
        );
        return;
      }

      // 특수문자 사용 여부 확인
      if (RegExp(r'[~!@#$%^&*()_+|<>?:{}]').hasMatch(groupName)) {
        state = state.copyWith(
          groupName: trimmedName,
          errorMessage: '특수문자는 사용할 수 없습니다.',
          isButton: false,
          isLoadingButton: false,
        );
        return;
      }

      // 한글과 영문만 입력 가능
      if (!RegExp(r'^[가-힣a-zA-Z\s]+$').hasMatch(trimmedName)) {
        state = state.copyWith(
          groupName: trimmedName,
          errorMessage: '한글과 영문만 입력해주세요.',
          isButton: false,
          isLoadingButton: false,
        );
        return;
      }

      // 띄어쓰기 포함 여부 확인
      if (groupName.contains(' ')) {
        state = state.copyWith(
          groupName: trimmedName,
          errorMessage: '띄어쓰기는 사용할 수 없습니다.',
          isButton: false,
          isLoadingButton: false,
        );
        return;
      }

      // 문자 길이 (2~8자)
      if (trimmedName.length < 2 || trimmedName.length > 8) {
        state = state.copyWith(
          groupName: trimmedName,
          errorMessage: '2~8자로 입력해주세요.',
          isButton: false,
          isLoadingButton: false,
        );
        return;
      }

      // 그룹 생성 정상적 입력
      state = state.copyWith(
        groupName: trimmedName,
        errorMessage: null,
        isButton: true,
        isLoadingButton: false,
      );
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
final NotifierProvider<GroupCreateNotifier, GroupState> groupCreateProvider =
    NotifierProvider<GroupCreateNotifier, GroupState>(GroupCreateNotifier.new);
