import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/group_enum_state_provider.dart';
import 'package:mango/state/group_enum_state.dart';
import 'package:mango/view/group/widget/group_empty_widget.dart';
import 'package:mango/view/group/widget/group_firstRequest_widget.dart';
import 'package:mango/view/group/widget/group_exist_widget.dart';

class GroupView extends ConsumerStatefulWidget {
  const GroupView({super.key});

  @override
  ConsumerState<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends ConsumerState<GroupView> {
  @override
  void initState() {
    super.initState();
    // 추후 그룹이 있는지 없는지 확인하여 초기 뷰 구성할 코드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(grouViewStateProvider.notifier).state =
          GroupViewState.empty; // 테스트: 다른 뷰 이동한 후, 다시 그룹 뷰 오면 초기화면으로 초기화
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
