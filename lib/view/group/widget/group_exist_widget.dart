import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/group_enum_state_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/state/group_enum_state.dart';

class GrouExistWidget extends ConsumerStatefulWidget {
  const GrouExistWidget({super.key});

  @override
  ConsumerState<GrouExistWidget> createState() => _GroupUserListWidgetState();
}

class _GroupUserListWidgetState extends ConsumerState<GrouExistWidget> {
  Group? get _group => ref.watch(groupProvider);
  AuthInfo? get user => ref.watch(loginAuthProvider);
  GroupNotifier get groupNotifier => ref.read(groupProvider.notifier);

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);
    final double fontSizeMediaQuery =
        MediaQuery.of(context).size.width; // 폰트 사이즈

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                Text(
                  '${_group?.groupName}', // 추후 그룹 코드가 들어갈 예정
                  style: TextStyle(fontSize: fontSizeMediaQuery * 0.06),
                ),
                const Spacer(),
                Text(
                  '냉장고ID: ${_group?.groupId ?? 0}', // 추후 그룹 코드가 들어갈 예정
                  style: TextStyle(fontSize: fontSizeMediaQuery * 0.05),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          ExpansionTile(
            initiallyExpanded: true,  // 처음부터 펼쳐지게
            title: Text(
              '그룹원(${1})',
              style: TextStyle(fontSize: fontSizeMediaQuery * 0.05),
            ),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(design.marginAndPadding),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '그룹장',
                          style: TextStyle(fontSize: fontSizeMediaQuery * 0.06),
                        ),
                        const Icon(
                          Icons.emoji_events,
                          size: 26,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // 배경색
              foregroundColor: Colors.black, // 텍스트색
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // 버튼 라운딩
              ),
            ),
            onPressed: () async {
              groupNotifier.exitCurrentGroup(user?.usrId ?? 0, _group?.groupId ?? 0);
              ref.read(grouViewStateProvider.notifier).state = GroupViewState.empty;
            },
            child:  Text(
                    "그룹 나가기",
                    style: TextStyle(fontSize: fontSizeMediaQuery * 0.04),
                  ),
          ),
        ],
      ),
    );
  }
}
