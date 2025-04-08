import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/group_enum_state_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/state/group_enum_state.dart';
import 'package:mango/toastMessage.dart';

class GroupFirstRequestWidget extends ConsumerWidget {
  const GroupFirstRequestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Group? _group = ref.watch(groupProvider);
    final AuthInfo? user = ref.watch(loginAuthProvider);
    final GroupNotifier groupNotifier = ref.read(groupProvider.notifier);
    final double fontSizeMediaQuery =
        MediaQuery.of(context).size.width; // 폰트 사이즈

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
                      _group?.groupName ?? '',
                      style: TextStyle(fontSize: fontSizeMediaQuery * 0.04),
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
              backgroundColor: Colors.blue, // 배경색
              foregroundColor: Colors.black, // 텍스트색
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // 버튼 라운딩
              ),
            ),
            onPressed: () async {
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
                          onPressed: () => context.pop(), // "취소" 버튼: 알럿 창 닫기
                          child: const Text('취소'),
                        ),
                        TextButton(
                          onPressed: () async {
                            context.pop(); // 알럿 창 닫기
                            if (await groupNotifier.exitCurrentGroup(
                              user?.usrId ?? 0,
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
            child: Text(
              "그룹 나가기",
              style: TextStyle(fontSize: fontSizeMediaQuery * 0.04),
            ),
          ),
        ],
      ),
    );
  }
}
