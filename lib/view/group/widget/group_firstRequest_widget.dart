import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/group_enum_state_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/services/group_shared_prefs.dart';
import 'package:mango/state/group_enum_state.dart';
import 'package:mango/toastMessage.dart';

class GroupFirstRequestWidget extends ConsumerWidget {
  const GroupFirstRequestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthInfo? user = ref.watch(loginAuthProvider);
    final GroupNotifier groupNotifier = ref.read(groupProvider.notifier);
    final GroupSharedPrefs groupPrefs = GroupSharedPrefs();
    final double fontSizeMediaQuery = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: Future.wait([
        groupPrefs.getJoinedGroupId(),
        groupPrefs.getJoinedGroupName(),
        groupPrefs.getjoinedGroupOwnerName(),
        groupPrefs.getjoinedGroupCode(),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final int? joinGroupId = snapshot.data![0] as int?;
        final String? joinGroupName = snapshot.data![1] as String?;
        final String? joinedGroupOwnerName = snapshot.data![2] as String?;
        final String? joinedGroupCode = snapshot.data![3] as String?;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: fontSizeMediaQuery * 0.15),
            Image.asset("assets/images/group_request.png"),
            const SizedBox(height: 77),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style.copyWith(
                  fontSize: Design.appTitleFontSize,
                  fontWeight: FontWeight.bold,
                ),
                children: const <InlineSpan>[
                  TextSpan(text: '현재 '),
                  TextSpan(
                    text: '승인 대기중',
                    style: TextStyle(
                      color: Colors.green, // 빨간색 강조
                    ),
                  ),
                  TextSpan(text: '입니다.'),
                ],
              ),
            ),
            const SizedBox(height: 34),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '그룹명',
                      style: TextStyle(
                        fontSize: Design.appTitleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' : $joinGroupName의 냉장고',
                      style: const TextStyle(fontSize: Design.appTitleFontSize),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '그룹장',
                      style: TextStyle(
                        fontSize: Design.appTitleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      ' : $joinedGroupOwnerName',
                      style: const TextStyle(fontSize: Design.appTitleFontSize),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '냉장고 ID',
                      style: TextStyle(
                        fontSize: Design.appTitleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' : $joinedGroupCode',
                      style: const TextStyle(fontSize: Design.appTitleFontSize),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 34),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.07,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD0D0),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
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
                                final success = await groupNotifier
                                    .exitCurrentGroup(
                                      user?.usrId ?? 0,
                                      joinGroupId ?? 0,
                                    );

                                if (success) {
                                  await groupPrefs.removeJoinedGroup();
                                  ref
                                      .read(grouViewStateProvider.notifier)
                                      .state = GroupViewState.empty;
                                  toastMessage(
                                    context,
                                    "'$joinGroupName' 그룹을 나갔습니다.",
                                  );
                                } else {
                                  toastMessage(
                                    context,
                                    "'$joinGroupName' 그룹을 나갈 수 없습니다.",
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
                child: const Text(
                  "참가 취소",
                  style: TextStyle(fontSize: Design.normalFontSize4),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
