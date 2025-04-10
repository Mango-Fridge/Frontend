import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/group_enum_state_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/state/group_enum_state.dart';
import 'package:mango/toastMessage.dart';

class GrouExistWidget extends ConsumerStatefulWidget {
  const GrouExistWidget({super.key});

  @override
  ConsumerState<GrouExistWidget> createState() => _GroupUserListWidgetState();
}

class _GroupUserListWidgetState extends ConsumerState<GrouExistWidget> {
  Group? get _group => ref.watch(groupProvider);
  AuthInfo? get _user => ref.watch(loginAuthProvider);
  GroupNotifier get groupNotifier => ref.read(groupProvider.notifier);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(groupProvider.notifier)
          .groupUserList(_user?.usrId ?? 0, _group?.groupId ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);
    final double fontSizeMediaQuery =
        MediaQuery.of(context).size.width; // 폰트 사이즈
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                Text(
                  '${_group?.groupName}',
                  style: TextStyle(fontSize: fontSizeMediaQuery * 0.06),
                ),
                const Spacer(),
                Text(
                  '냉장고ID: ${_group?.groupCode ?? ''}',
                  style: TextStyle(fontSize: fontSizeMediaQuery * 0.05),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ExpansionTile(
            // 승인 요청 대기
            initiallyExpanded: true, // 처음부터 펼쳐지게
            title: Text(
              '승인 요청 대기(${_group?.groupHopeUsers?.length ?? 0})',
              style: TextStyle(fontSize: fontSizeMediaQuery * 0.05),
            ),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                children:
                    _group?.groupHopeUsers?.map((GroupHopeUser user) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(design.marginAndPadding),
                        child: Row(
                          children: <Widget>[
                            Text(
                              user.username,
                              style: TextStyle(
                                fontSize: fontSizeMediaQuery * 0.06,
                              ),
                            ),
                            const Spacer(),
                            if (_user?.usrId == _group?.groupOwnerId) ...<Widget>{
                              actionButton(
                                label: "거절",
                                onPressed: () async {
                                  await groupNotifier.putGroupReject( 
                                    user.userId,
                                    _group?.groupId ?? 0,
                                  );
                                  await ref
                                      .read(groupProvider.notifier)
                                      .groupUserList(
                                        _user?.usrId ?? 0,
                                        _group?.groupId ?? 0,
                                      );
                                },
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                fontSizeMediaQuery: fontSizeMediaQuery,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              actionButton(
                                label: "승인",
                                onPressed: () async {
                                  await groupNotifier.postGroupApprove(
                                    user.userId,
                                    _group?.groupId ?? 0,
                                  );
                                  await ref
                                      .read(groupProvider.notifier)
                                      .groupUserList(
                                        _user?.usrId ?? 0,
                                        _group?.groupId ?? 0,
                                      );
                                },
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                fontSizeMediaQuery: fontSizeMediaQuery,
                              ),
                            },
                          ],
                        ),
                      );
                    }).toList() ??
                    <Widget>[const SizedBox()],
              ),
            ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
            // 그룹원
            initiallyExpanded: true, // 처음부터 펼쳐지게
            title: Text(
              '그룹원(${_group?.groupUsers?.length})',
              style: TextStyle(fontSize: fontSizeMediaQuery * 0.05),
            ),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                children:
                    _group?.groupUsers?.map((GroupUser user) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(design.marginAndPadding),
                        child: Row(
                          children: <Widget>[
                            Text(
                              user.username,
                              style: TextStyle(
                                fontSize: fontSizeMediaQuery * 0.06,
                              ),
                            ),
                            if (_group?.groupOwnerId ==
                                user.userId) ...<Widget>[
                              const Icon(
                                Icons.emoji_events,
                                size: 26,
                                color: Colors.amber,
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList() ??
                    [const SizedBox()],
              ),
            ],
          ),
          const SizedBox(height: 5),
          actionButton(
            label: "그룹 나가기",
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (BuildContext context) => AlertDialog(
                      title: const Text('그룹 나가기'),
                      content: const Text(
                        '해당 그룹을 나가면 되돌릴 수 없습니다.\n그룹을 나가겠습니까?',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text('취소'),
                        ),
                        TextButton(
                          onPressed: () async {
                            context.pop();
                            if (await groupNotifier.exitCurrentGroup(
                              _user?.usrId ?? 0,
                              _group?.groupId ?? 0,
                            )) {
                              ref.read(grouViewStateProvider.notifier).state =
                                  GroupViewState.empty;
                              toastMessage(
                                context,
                                "'${_group?.groupName ?? ''}' 그룹을 나갔습니다.",
                              );
                            } else {
                              toastMessage(
                                context,
                                "'${_group?.groupName ?? ''}' 그룹을 나갈 수 없습니다.",
                                type: ToastmessageType.errorType,
                              );
                            }
                          },
                          child: const Text('확인'),
                        ),
                      ],
                    ),
              );
            },
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            fontSizeMediaQuery: fontSizeMediaQuery,
          ),
        ],
      ),
    );
  }
}

Widget actionButton({
  required String label,
  required VoidCallback onPressed,
  required double screenWidth,
  required double screenHeight,
  required double fontSizeMediaQuery,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      minimumSize: Size(screenWidth * 0.15, screenHeight * 0.04),
    ),
    onPressed: onPressed,
    child: Text(label, style: TextStyle(fontSize: fontSizeMediaQuery * 0.04)),
  );
}
