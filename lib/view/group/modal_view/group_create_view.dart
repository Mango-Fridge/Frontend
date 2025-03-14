import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/state/group_state.dart';
import 'package:mango/providers/group_create_provider.dart';
import 'package:mango/view/group/sub_widget/group_common_button.dart';
import 'package:mango/view/group/sub_widget/group_modal_title.dart';

// 그룹 생성하기 모달 뷰
class GroupCreateView extends ConsumerWidget {
  const GroupCreateView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GroupState groupState = ref.watch(groupCreateProvider);
    final GroupCreateNotifier groupNotifier = ref.read(
      groupCreateProvider.notifier,
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Center(
        child: Column(
          children: <Widget>[
            groupModalTitle(
              context: context,
              textTitle: '냉장고 생성하기',
              textSub: '냉장고 이름을 정하여 만들어보세요',
            ),
            // const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '2~8자 입력',
                  errorText: groupState.errorMessage, // 에러 메시지 표시
                ),
                onChanged:
                    (String groupName) => groupNotifier.checkGroupName(
                      groupName,
                    ), // 입력값 지속적으로 상태확인
              ),
            ),
            const Spacer(),
            groupCommonButton(
              context: context,
              text: "생성하기",
              onPressed:
                  groupState.isButton
                      ? () {
                        // 생성 로직 추가
                        ref.read(groupBoolProvider.notifier).state = true; // 그룹뷰 전환 테스트용도 - 추후 삭제
                        print(groupState.groupName);
                        context.pop(); // Sheet 닫기

                        // 토스트 메시지
                        Fluttertoast.showToast(
                          msg: "'${groupState.groupName}' 그룹이 생성되었습니다.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.black,
                          fontSize: 16.0,
                        );
                      }
                      : null,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
