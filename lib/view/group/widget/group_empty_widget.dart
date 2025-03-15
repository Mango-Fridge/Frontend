import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/group_modal_state_provider.dart';
import 'package:mango/state/group_modal_state.dart';
import 'package:mango/view/group/modal_view/group_modal_state_view.dart';
import 'package:mango/view/group/sub_widget/group_common_button.dart';

// 그룹이 존재하지 않을 때, 표시되는 위젯
Widget groupEmptyWidget(BuildContext context, WidgetRef ref) {
  return SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                groupGuideText(context), // 안내 문구
                const SizedBox(height: 40),
                groupModalStartButton(context, ref), // '그룹' 시작하기 버튼(모달 띄우기)
              ],
            ),
          );
}

// 안내 문구 텍스트 글
Widget groupGuideText(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.9,
    child: const Text(
      "그룹이 없습니다.\n그룹을 생성하거나 참여해보세요.",
      style: TextStyle(fontSize: 22),
      textAlign: TextAlign.center,
    ),
  );
}

// 시작하기 버튼
Widget groupModalStartButton(BuildContext context, WidgetRef ref) {
  return groupCommonButton(
    context: context,
    text: "시작하기",
    onPressed: () {
      ref.read(groupModalStateProvider.notifier).state =
          GroupModalState.start; // 시작하기 버튼 클릭 시, 모달 '시작하기' 뷰로 초기화
      groupModalStateView(context, ref);
    },
  );
}
