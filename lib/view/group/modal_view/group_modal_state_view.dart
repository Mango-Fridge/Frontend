import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/state/group_modal_state.dart';
import 'package:mango/providers/group_modal_state_provider.dart';
import 'package:mango/view/group/modal_view/group_create_view.dart';
import 'package:mango/view/group/modal_view/group_participation_view.dart';
import 'package:mango/view/group/modal_view/group_start_view.dart';

// 상태에따라 모달창을 보여줌
void groupModalStateView(BuildContext context, WidgetRef ref) {
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
                  return const GroupStartView(); // 모달 시작하기 뷰
                case GroupModalState.create:
                  return const GroupCreateView(); // 모달 생성하기 뷰
                case GroupModalState.participation:
                  return const GroupParticipationView(); // 모달 참여하기 뷰
              }
            },
          ),
        ),
      );
    },
  );
}
