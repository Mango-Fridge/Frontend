import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:mango/providers/group_enum_state_provider.dart';
import 'package:mango/state/group_enum_state.dart';
import 'package:mango/view/group/modal_view/group_modal_state_view.dart';
import 'package:mango/view/group/sub_widget/group_action_button.dart';

// 그룹이 존재하지 않을 때, 표시되는 위젯
class GroupEmptyWidget extends ConsumerWidget {
  const GroupEmptyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Design design = Design(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          groupGuideText(context), // 안내 문구
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createButton(context, ref),
              const SizedBox(width: 40),
              participationButton(context, ref),
            ],
          ),
          SizedBox(height: design.homeBottomHeight * 2),
        ],
      ),
    );
  }
}

// 안내 문구 텍스트 글
Widget groupGuideText(BuildContext context) {
  return Column(
    children: [
      Image.asset("assets/images/null_group.png"),
      const SizedBox(height: 32),
      const Text(
        "소속된 냉장고가 없습니다.",
        style: TextStyle(fontSize: Design.appTitleFontSize),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

// 그룹 생성하기 버튼
Widget createButton(BuildContext context, WidgetRef ref) {
  return groupActionButton(
    context: context,
    text: "냉장고 생성",
    icon: Icons.add_outlined,
    onPressed: () {
      ref.read(groupModalStateProvider.notifier).state = GroupModalState.create;
      groupModalStateView(context, ref);
    },
  );
}

// 그룹 참여하기 버튼
Widget participationButton(BuildContext context, WidgetRef ref) {
  return groupActionButton(
    context: context,
    text: "냉장고 참가",
    icon: Icons.subdirectory_arrow_right,
    onPressed: () {
      ref.read(groupModalStateProvider.notifier).state =
          GroupModalState.participation;
      groupModalStateView(context, ref);
    },
  );
}
