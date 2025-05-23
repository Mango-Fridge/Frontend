import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
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
class GroupParticipationView extends ConsumerStatefulWidget {
  const GroupParticipationView({super.key});

  @override
  ConsumerState<GroupParticipationView> createState() =>
      _GroupParticipationViewState();
}

class _GroupParticipationViewState
    extends ConsumerState<GroupParticipationView> {
  GroupState get groupState => ref.watch(groupParticipationProvider);
  GroupParticipationNotifier get groupNotifier =>
      ref.read(groupParticipationProvider.notifier);
  AuthInfo? get user => ref.watch(loginAuthProvider);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double fontSizeMediaQuery =
        MediaQuery.of(context).size.width; // 폰트 사이즈
    final groupPrefs = GroupSharedPrefs();
    final Design design = Design(context);

    return SizedBox(
      height:
          groupState.isButton
              ? MediaQuery.of(context).size.height * 0.62
              : MediaQuery.of(context).size.height * 0.4,
      child: Center(
        child: Column(
          children: <Widget>[
            groupModalTitle(context: context, textTitle: '냉장고 참가'),
            if (groupState.isButton) ...[
              // 그룹이 존재하는 경우
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.amber, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      '${groupState.groupName ?? ''}의 냉장고',
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: fontSizeMediaQuery * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.emoji_events, color: Colors.amber, size: 25),
                        SizedBox(width: 6),
                        Text(
                          groupState.groupOwnerName ?? '',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: fontSizeMediaQuery * 0.08),
            ],
            if (!groupState.isButton) ...[
              const SizedBox(height: 40),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(
                        context,
                      ).style.copyWith(fontSize: Design.appTitleFontSize),
                      children: const <InlineSpan>[
                        TextSpan(text: '참가하고자 하는 '),
                        TextSpan(
                          text: '냉장고 ID',
                          style: TextStyle(
                            color: Colors.red, // 빨간색 강조
                          ),
                        ),
                        TextSpan(text: '를'),
                      ],
                    ),
                  ),
                  const Text(
                    '입력해주세요.',
                    style: TextStyle(fontSize: Design.appTitleFontSize),
                  ),
                ],
              ),
            ],
            if (groupState.isButton) ...[
              const Column(
                children: [
                  Text(
                    '해당 냉장고에 참여하는게',
                    style: TextStyle(fontSize: Design.appTitleFontSize),
                  ),
                  Text(
                    '맞으신가요?',
                    style: TextStyle(fontSize: Design.appTitleFontSize),
                  ),
                ],
              ),
            ],
            SizedBox(height: fontSizeMediaQuery * 0.05),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.2,
              child: TextField(
                controller: _controller,
                onChanged:
                    (String groupCode) =>
                        groupNotifier.isGroupValid(groupCode), // 입력값 지속적으로 상태확인
                maxLength: 15,
                decoration: InputDecoration(
                  hintText: 'ex)GRP-00-00000',
                  hintStyle: const TextStyle(fontSize: 17, color: Colors.grey),
                  errorText: groupState.errorMessage,
                  filled: true,
                  fillColor: design.subColor,
                  contentPadding: const EdgeInsets.only(left: 13),
                  suffixIcon:
                      _controller.text.isNotEmpty
                          ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.red),
                            onPressed: () {
                              _controller.clear();
                              groupNotifier.isGroupValid(''); // 상태 초기화도 같이
                            },
                          )
                          : null,
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
            SizedBox(height: fontSizeMediaQuery * 0.05),
            if (groupState.isButton) ...[
              groupCommonButton(
                context: context,
                text: "참가 요청하기",
                onPressed:
                    groupState.isButton
                        ? () async {
                          if (await groupNotifier.postGroupJoin(
                            user?.usrId ?? 0,
                            groupState.groupId ?? 0,
                          )) {
                            await groupPrefs.saveJoinedGroup(
                              groupState.groupId ?? 0,
                              groupState.groupName ?? '',
                              groupState.groupOwnerName ?? '',
                              groupState.groupCode ?? ''
                            ); // 참여 희망 그룹id, 이름 로컬 저장
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
            ],
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
