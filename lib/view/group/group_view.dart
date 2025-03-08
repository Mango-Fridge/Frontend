import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/group_modal_state.dart';
import 'package:mango/providers/group_modal_state_provider.dart';
import 'package:mango/view/group/modal_view/show_modal_start_group_view.dart';
import 'package:mango/view/group/subView/group_common_button.dart';

class GroupView extends ConsumerWidget {
  const GroupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 본문 콘텐츠를 AppBar 뒤로 확장
      appBar: AppBar(
        title: const Text("그룹", style: TextStyle(fontSize: 30)),
        centerTitle: false, // 앱바 텍스트 중앙정렬X
        backgroundColor: Colors.transparent, // AppBar의 배경색을 투명하게 설정 (모달 띄울 때)
      ),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                groupGuideText(context), // 안내 문구
                const SizedBox(height: 40),
                groupModalStartButton(context, ref), // '그룹' 시작하기 버튼(모달 띄우기)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 안내 문구 텍스트 글
Widget groupGuideText(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.9,
    child: const Text(
      "그룹이 없습니다.\n그룹을 생성하거나 참여해보세요.",
      style: TextStyle(fontSize: 22),
      textAlign: TextAlign.center,
    ),
  );
}

// 시작하기 버튼
Widget groupModalStartButton(BuildContext context, WidgetRef ref) {
  return groupCommonButton(
    context: context,
    text: "시작하기",
    onPressed: () {
      ref.read(groupModalStateProvider.notifier).state = GroupModalState.start; // 시작하기 버튼 클릭 시, 모달 '시작하기' 뷰로 초기화
      showModalStartGroupView(context, ref);
    },
  );
}
