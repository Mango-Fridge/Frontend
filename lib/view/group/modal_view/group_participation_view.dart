import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/group_state_provider.dart';
import 'package:mango/view/group/subView/group_common_button.dart';
import 'package:mango/view/group/subView/group_modal_title.dart';

// 그룹 참여하기 모달 뷰
class GroupParticipationView extends ConsumerWidget {
  const GroupParticipationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GroupState groupState = ref.watch(groupStateProvider);
    // final GroupStateNotifier groupNotifier = ref.read(groupStateProvider.notifier);

    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          children: <Widget>[
            groupModalTitle(
              context: context,
              textTitle: '기존 냉장고 참여하기',
              textSub: '다른 냉장고ID를 입력해 참여하세요',
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '냉장고ID 입력',
                  errorText: groupState.errorMessage, // 에러 메시지 표시
                ),
                // onChanged:  // 입력값 지속적으로 상태확인
              ),
            ),
            const Spacer(),
            groupCommonButton(
              context: context,
              text: "참여하기",
              onPressed: () {
                // 참여 로직 추가
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
