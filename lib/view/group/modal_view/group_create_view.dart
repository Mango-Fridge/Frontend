import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/group_enum_state_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/state/group_enum_state.dart';
import 'package:mango/state/group_state.dart';
import 'package:mango/providers/group_create_provider.dart';
import 'package:mango/toastMessage.dart';
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
    final AuthInfo? user = ref.watch(loginAuthProvider);
    final Design design = Design(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(
          top: BorderSide(color: Colors.amber, width: 5),
          // left: BorderSide(color: Colors.amber, width: 5),
          // right: BorderSide(color: Colors.amber, width: 5),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.52,
      child: Center(
        child: Column(
          children: <Widget>[
            groupModalTitle(context: context, textTitle: '냉장고 생성'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: Design.tabBarSelectedFontSize),
                  const Text(
                    '냉장고의 이름을 정해주세요.',
                    style: TextStyle(
                      fontSize: Design.appTitleFontSize,
                      fontWeight: FontWeight.w300, // 얇게
                    ),
                  ),
                  const SizedBox(height: Design.normalFontSize4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.2,
                    child: TextField(
                      onChanged:
                          (String groupName) =>
                              groupNotifier.checkGroupName(groupName),
                      maxLength: 8,
                      decoration: InputDecoration(
                        hintText: 'ex) 홍길동의 냉장고',
                        hintStyle: const TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                        errorText: groupState.errorMessage,
                        filled: true,
                        fillColor: design.subColor,
                        contentPadding: const EdgeInsets.only(
                          left: Design.normalFontSize1,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.amber),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.amber),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          height: 1.2,
                        ),
                        counterText: "",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            groupCommonButton(
              context: context,
              text: "생성하기",
              isCreateButton: true,
              onPressed:
                  groupState.isButton
                      ? () async {
                        // Group Create API: 그룹 생성
                        if (await groupNotifier.createGroup(
                          user?.usrId ?? 0,
                          '${groupState.groupName}',
                        )) {
                          await ref
                              .read(groupProvider.notifier)
                              .loadGroup(user?.usrId ?? 0);
                          await ref
                              .read(groupProvider.notifier)
                              .groupUserList(
                                user?.usrId ?? 0,
                                ref.read(groupProvider)?.groupId ?? 0,
                              );
                          ref.read(grouViewStateProvider.notifier).state =
                              GroupViewState.exist; // 그룹 생성으로 그룹 존재 뷰로
                          context.pop(); // Sheet 닫기
                          toastMessage(
                            context,
                            "'${groupState.groupName}' 그룹이 생성되었습니다.",
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
