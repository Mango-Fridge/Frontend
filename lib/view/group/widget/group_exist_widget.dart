import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/group_enum_state_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/providers/refrigerator_provider.dart';
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
    // final Design design = Design(context);
    // final double fontSizeMediaQuery = MediaQuery.of(context).size.width;
    // final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;

    final List<GroupHopeUser> hopeUsers = _group?.groupHopeUsers ?? [];
    final List<GroupUser> groupUsers = groupNotifier.getSortedGroupUsers();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_group?.groupName}의 냉장고',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _group?.groupCode ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: _group?.groupCode ?? ''),
                        );
                        toastMessage(context, 'ID가 복사되었습니다');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF78BEFF),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'ID 복사',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Text(
                '그룹장',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset("assets/images/crown.png"),
                  const SizedBox(width: 4),
                  Text(
                    '${groupNotifier.groupOwnerName}',
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 승인 요청 대기 섹션
          if (hopeUsers.isNotEmpty) ...{
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  '승인 요청 대기',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Text(
                  '(${hopeUsers.length}명)',
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4D8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber),
              ),
              child: Column(
                children:
                    hopeUsers.map((GroupHopeUser user) {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              user.username,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          if (_user?.usrId == _group?.groupOwnerId) ...{
                            ElevatedButton(
                              onPressed: () async {
                                await groupNotifier.putGroupApprove(
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade200,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('승인'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade200,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('거절'),
                            ),
                          },
                        ],
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 20),
          },

          // 그룹원 리스트
          // if (groupUsers.isNotEmpty) ...{
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '그룹원',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              Text(
                '(${groupUsers.length}명)',
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4D8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber),
            ),
            child: Column(
              children:
                  groupUsers.map((user) {
                    final bool isCurrentUserOwner =
                        _user?.usrId == _group?.groupOwnerId;
                    final bool isOtherUser = _user?.usrId != user.userId;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  user.username,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          if (isCurrentUserOwner && isOtherUser) ...{
                            ElevatedButton(
                              onPressed: () async {
                                await groupNotifier.putGroupOwner(
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('위임하기'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () async {
                                await groupNotifier.exitCurrentGroup(
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade200,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('내보내기'),
                            ),
                          },
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),

          // },
          const SizedBox(height: 20),
          // 그룹 나가기 버튼
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (await groupNotifier.exitCurrentGroup(
                    _user?.usrId ?? 0,
                    _group?.groupId ?? 0,
                  )) {
                    toastMessage(
                      context,
                      "'${_group?.groupName ?? ''}' 그룹을 나갔습니다.",
                    );
                    await ref
                        .read(groupProvider.notifier)
                        .loadGroup(_user?.usrId ?? 0);
                    ref.read(grouViewStateProvider.notifier).state =
                        GroupViewState.empty;
                  } else {
                    toastMessage(
                      context,
                      "'${_group?.groupName ?? ''}' 그룹을 나갈 수 없습니다.",
                      type: ToastmessageType.errorType,
                    );
                  }
                  ref.read(refrigeratorNotifier.notifier).resetState();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFFD0D0),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('그룹 나가기', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 8),
              const Text(
                '* 그룹장일 때 나갈 수 없습니다.',
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
