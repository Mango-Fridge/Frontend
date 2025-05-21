import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/group_enum_state_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/services/group_shared_prefs.dart';
import 'package:mango/state/group_enum_state.dart';
import 'package:mango/state/group_state.dart';
import 'package:mango/providers/group_participation_provider.dart';
import 'package:mango/toastMessage.dart';
import 'package:mango/view/group/sub_widget/group_common_button.dart';
import 'package:mango/view/group/sub_widget/group_modal_title.dart';

// 그룹 참여하기 모달 뷰
class GroupParticipationView extends ConsumerWidget {
  const GroupParticipationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GroupState groupState = ref.watch(groupParticipationProvider);
    final GroupParticipationNotifier groupNotifier = ref.read(
      groupParticipationProvider.notifier,
    );
    final AuthInfo? user = ref.watch(loginAuthProvider);
    final double fontSizeMediaQuery =
        MediaQuery.of(context).size.width; // 폰트 사이즈
    final groupPrefs = GroupSharedPrefs();

    return SizedBox(
      height:
          groupState.isButton
              ? MediaQuery.of(context).size.height * 0.55
              : MediaQuery.of(context).size.height * 0.45,
      child: Center(
        child: Column(
          children: <Widget>[
            groupModalTitle(
              context: context,
              textTitle: '기존 냉장고 참여하기',
            ),
            // const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '냉장고 코드 입력',
                  errorText: groupState.errorMessage, // 에러 메시지 표시
                ),
                onChanged:
                    (String groupCode) =>
                        groupNotifier.isGroupValid(groupCode), // 입력값 지속적으로 상태확인
              ),
            ),
            const Spacer(),
            if (groupState.isButton) ...[
              // 그룹이 존재하는 경우
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Text(
                      groupState.groupName ?? '',
                      style: TextStyle(
                        fontSize: fontSizeMediaQuery * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.emoji_events,
                          size: 20,
                          color: Colors.amber,
                        ),
                        Text(
                          '${groupState.groupOwnerName ?? ''}외 ${groupState.groupMemberCount ?? 0}명',
                          style: TextStyle(fontSize: fontSizeMediaQuery * 0.04),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                '참여하려는 냉장고가 맞나요?',
                style: TextStyle(fontSize: fontSizeMediaQuery * 0.05),
              ),
            ],
            const Spacer(),
            groupCommonButton(
              context: context,
              text: "참가 요청하기",
              isCreateButton: false, 
              onPressed:
                  groupState.isButton
                      ? () async {
                        if (await groupNotifier.postGroupJoin(
                          user?.usrId ?? 0,
                          groupState.groupId ?? 0,
                        )) {
                          await groupPrefs.saveJoinedGroup(groupState.groupId ?? 0, groupState.groupName ?? ""); // 참여 희망 그룹id, 이름 로컬 저장
                          ref.read(grouViewStateProvider.notifier).state =
                              GroupViewState
                                  .firstRequest; // 그룹 1개이상X, 그룹 참여 요청 시
                          context.pop(); // Sheet 닫기
                          toastMessage(
                            context,
                            "'${groupState.groupName}' 참여 요청을 보냈습니다.",
                          );
                        } else {
                          toastMessage(
                            context,
                            "'${groupState.groupName}' 참여 요청을 보내지 못했습니다.",
                            type: ToastmessageType.errorType,
                          );
                        }
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
