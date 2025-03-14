import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/group_provider.dart';
import 'package:mango/view/group/widget/group_empty_widget.dart';
import 'package:mango/view/group/widget/group_userList_widget.dart';

class GroupView extends ConsumerStatefulWidget {
  const GroupView({super.key});

  @override
  ConsumerState<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends ConsumerState<GroupView> {
  @override
  void initState() { // 테스트용 - 생성하기, 참여하기 한 후, 다른 뷰로 다녀올 시 초기화하기 위함
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(groupBoolProvider.notifier).state = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool groupBool = ref.watch(groupBoolProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("그룹", style: TextStyle(fontSize: 30)),
        centerTitle: false, // 앱바 텍스트 중앙정렬X
      ),
      body:
          groupBool
              ? const GroupUserListWidget()
              : groupEmptyWidget(context, ref), // 참가하기 혹은 생성하기일 때
    );
  }
}
