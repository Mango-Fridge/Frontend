import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/view/group/modal_view/group_create_view.dart';
import 'package:mango/view/group/modal_view/group_participation_view.dart';
import 'package:mango/view/group/modal_view/group_start_view.dart';

// 그룹(냉장고) 유효성 상태관리를 위해 사용

// 상태클래스
class GroupState {
  final String groupName; // 그룹 이름
  final String? errorMessage; // 에러메시지
  final bool isButton; // 버튼활성

  GroupState({
    required this.groupName,
    this.errorMessage,
    required this.isButton,
  });

  GroupState copyWith({
    String? groupName,
    String? errorMessage,
    bool? isButton,
  }) {
    return GroupState(
      groupName: groupName ?? this.groupName,
      errorMessage: errorMessage,
      isButton: isButton ?? this.isButton,
    );
  }
}

class GroupStateNotifier extends Notifier<GroupState> {
  @override
  GroupState build() {
    // 초기 상태
    return GroupState(groupName: '', errorMessage: null, isButton: false);
  }

  // 그룹 생성 유효성 검사 및 업데이트
  void updateGroupName(String groupName) {
    // 공백 제거
    final trimmedName = groupName.trim();

    // 문자가 공백일 때
    if (trimmedName == '') {
      state = state.copyWith(
        groupName: trimmedName,
        errorMessage: null,
        isButton: false,
      );
      return;
    }

    // 문자 길이 (2~8자)
    if (trimmedName.length < 2 || trimmedName.length > 8) {
      state = state.copyWith(
        groupName: trimmedName,
        errorMessage: "2~8자로 입력해주세요.",
        isButton: false,
      );
      return;
    }

    // 한글 & 영문만 (띄어쓰기, 특수문자 X)
    if (!RegExp(r'^[가-힣a-zA-Z]+$').hasMatch(trimmedName)) {
      state = state.copyWith(
        groupName: trimmedName,
        errorMessage: "한글과 영문만 입력해주세요.",
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

  // 그룹 생성하기 뷰로 갈 시, 상태초기화
  void resetState() {
    state = GroupState(groupName: '', errorMessage: null, isButton: false);
  }

  // 추후 참여하기 유효성 검사에 대한 로직 @@@@@@@@@@@@@@@@@@@
}

// NotifierProvider 정의
final groupStateProvider = NotifierProvider<GroupStateNotifier, GroupState>(
  GroupStateNotifier.new,
);

// 모달 상태 enum 뷰
enum GroupModalState {
  start, // 그룹 - 시작하기 뷰
  create, // 그룹 - 생성하기 뷰
  participation, // 그룹 - 참여하기 뷰
}

// 모달 화면 상태 관리
final groupModalStateProvider = StateProvider<GroupModalState>((ref) {
  return GroupModalState.start; // 초기 값 - 그룹 '시작하기' 뷰
});

// 모달창을 보여주는 함수
void showModalStartGroupView(BuildContext context, WidgetRef ref) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true, // 키보드 올라올 때 모달 크기 조정 가능하게
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
        },
        behavior: HitTestBehavior.opaque, // 빈 공간 터치 가능하게
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, //키보드 높이만큼 패딩 추가
          ),
          child: Consumer(
            builder: (context, WidgetRef ref, child) {
              final groupModalState = ref.watch(
                groupModalStateProvider,
              ); // 상태를 계속 추적하여 변화

              switch (groupModalState) {
                case GroupModalState.start:
                  return const GroupStartView();
                case GroupModalState.create:
                  return const GroupCreateView();
                case GroupModalState.participation:
                  return const GroupParticipationView();
              }
            },
          ),
        ),
      );
    },
  );
}
