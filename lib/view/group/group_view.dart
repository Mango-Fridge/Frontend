import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/group/group.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/group_enum_state_provider.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/services/group_shared_prefs.dart';
import 'package:mango/state/group_enum_state.dart';
import 'package:mango/view/group/widget/group_empty_widget.dart';
import 'package:mango/view/group/widget/group_firstRequest_widget.dart';
import 'package:mango/view/group/widget/group_exist_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupView extends ConsumerStatefulWidget {
  const GroupView({super.key});

  @override
  ConsumerState<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends ConsumerState<GroupView> {
  Group? get _group => ref.watch(groupProvider);
  AuthInfo? get user => ref.watch(loginAuthProvider);

  final GroupSharedPrefs groupSharedPrefs = GroupSharedPrefs();

  @override
  void initState() {
    super.initState();
    // GRP-25-00007
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final int? joinedGroupId = await groupSharedPrefs.getJoinedGroupId();
      final String? getJoinedGroupName =
          await groupSharedPrefs.getJoinedGroupName();

      await ref.read(groupProvider.notifier).loadGroup(user?.usrId ?? 0);

      if (_group?.groupId != null) {
        groupSharedPrefs.removeJoinedGroup();
        ref.read(grouViewStateProvider.notifier).state = GroupViewState.exist;
      } else if (joinedGroupId != null && getJoinedGroupName != null) {
        ref.read(grouViewStateProvider.notifier).state =
            GroupViewState.firstRequest;
      } else {
        ref.read(grouViewStateProvider.notifier).state = GroupViewState.empty;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupViewState = ref.watch(grouViewStateProvider); // 상태를 계속 추적하여 변화
    final double fontSizeMediaQuery =
        MediaQuery.of(context).size.width; // 폰트 사이즈

    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context) {
            return Text(
              "그룹",
              style: TextStyle(fontSize: fontSizeMediaQuery * 0.07),
            );
          },
        ),
        centerTitle: false, // 앱바 텍스트 중앙정렬X
      ),
      body: switch (groupViewState) {
        GroupViewState.empty => const GroupEmptyWidget(), // 초기 화면 그룹 뷰
        GroupViewState.exist => const GrouExistWidget(), // 그룹이 존재할 경우 보이는 뷰
        GroupViewState.firstRequest =>
          const GroupFirstRequestWidget(), // 처음 '참여하기' 하였을 때 보이는 뷰
      },
    );
  }
}
