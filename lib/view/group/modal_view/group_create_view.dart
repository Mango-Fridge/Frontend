import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/group_state_provider.dart';
import 'package:mango/view/group/subView/group_common_button.dart';
import 'package:mango/view/group/subView/group_modal_title.dart';

// 그룹 생성하기 모달 뷰
class GroupCreateView extends ConsumerWidget {
  const GroupCreateView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GroupState groupState = ref.watch(groupStateProvider);
    final GroupStateNotifier groupNotifier = ref.read(groupStateProvider.notifier);

    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          children: <Widget>[
            groupModalTitle(
              context: context,
              textTitle: '냉장고 생성하기',
              textSub: '냉장고 이름을 정하여 만들어보세요',
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '2~8자 입력',
                  errorText: groupState.errorMessage, // 에러 메시지 표시
                ),
                onChanged: (String groupName) => groupNotifier.updateGroupName(groupName), // 입력값 지속적으로 상태확인
              ),
            ),
            const Spacer(),
            groupCommonButton(
              context: context,
              text: "생성하기",
              onPressed: groupState.isButton? () {
                // 생성 로직 추가
                print(groupState.groupName);
              } : null,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
