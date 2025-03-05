import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/group_state_provider.dart';
import 'package:mango/view/group/group_participation_view.dart';
import 'package:mango/view/group/group_create_view.dart';
import 'package:mango/view/group/subView/group_common_button.dart';
import 'package:mango/view/group/subView/group_modal_title.dart';

// 그룹이 없을 때 보이는 '시작하기' 버튼
class GroupModalStartButton extends ConsumerWidget {
  const GroupModalStartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return groupCommonButton(
      context: context,
      text: "시작하기",
      onPressed: () {
        showModalStartGroupView(context, ref);
      },
    );
  }
}

// '시작하기' 클릭 시, 처음으로 보이는 모달창
void showModalStartGroupView(BuildContext context, WidgetRef ref) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 400,
        child: Center(
          child: Column(
            children: <Widget>[
              groupModalTitle(
                context: context,
                textTitle: '냉장고 시작하기',
                textSub: '어떤 방식으로 참여하시겠습니까?',
              ),
              const Spacer(),
              groupCommonButton(
                context: context,
                text: "생성하기",
                onPressed: () {
                  ref.read(groupStateProvider.notifier).resetState(); // 생성하기 뷰로 갈 때, 상태초기화
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true, // 키보드 올라올 때 모달 조정
                    builder: (BuildContext context) {
                      return const GroupCreateView(); // '그룹(냉장고)' 생성하기 버튼 클릭 시, 모달 뷰
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              groupCommonButton(
                context: context,
                text: "참여하기",
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true, // 키보드 올라올 때 모달 조정
                    builder: (BuildContext context) {
                      return const GroupParticipationView(); // '그룹(냉장고)' 생성하기 버튼 클릭 시, 모달 뷰
                    },
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    },
  );
}
