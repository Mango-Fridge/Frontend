import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final int? joinGroupId = snapshot.data![0] as int?;
        final String? joinGroupName = snapshot.data![1] as String?;

        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '승인 요청 대기',
                    style: TextStyle(
                      fontSize: fontSizeMediaQuery * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          joinGroupName ?? '',
                          style:
                              TextStyle(fontSize: fontSizeMediaQuery * 0.04),
                        ),
                        const Spacer(),
                        const Text(
                          '승인 대기 중',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
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
                            final success = await groupNotifier.exitCurrentGroup(
                              user?.usrId ?? 0,
                              joinGroupId ?? 0,
                            );

                            if (success) {
                              await groupPrefs.removeJoinedGroup();
                              ref.read(grouViewStateProvider.notifier).state =
                                  GroupViewState.empty;
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
                child: Text(
                  "그룹 나가기",
                  style: TextStyle(fontSize: fontSizeMediaQuery * 0.04),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}