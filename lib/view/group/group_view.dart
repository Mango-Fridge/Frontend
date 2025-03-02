import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/group_modal_provider.dart';
import 'package:mango/view/group/modal_content_example.dart';

class GroupView extends ConsumerWidget {
  const GroupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isModalOpen = ref.watch(groupModalProvider); // 모달 상태 Bool 감시

    return Scaffold(
      extendBodyBehindAppBar: true, // 본문 콘텐츠를 AppBar 뒤로 확장
      appBar: AppBar(
        title: const Text("그룹", style: TextStyle(fontSize: 30)),
        centerTitle: false, // 앱바 텍스트 중앙정렬X
        backgroundColor: Colors.transparent, // AppBar의 배경색을 투명하게 설정 (모달 띄울 때)
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                groupGuideText(context, ref), // 안내 문구
                const SizedBox(height: 20),
                groupStartButton(context, ref), // '그룹' 시작하기 버튼
              ],
            ),
          ),
          if (isModalOpen) ...[
            modalGesture(context, ref), // 모달 띄웠을 때 제스처 - Bool
            const ModalContentExample(), // 모달창
          ],
        ],
      ),
    );
  }
}

// 안내 문구 텍스트 글
Widget groupGuideText(BuildContext context, WidgetRef ref) {
  return const SizedBox(
    width: 330,
    child: Text(
      "그룹이 없습니다.\n그룹을 생성하거나 참여해보세요.",
      style: TextStyle(fontSize: 25),
      textAlign: TextAlign.center,
    ),
  );
}

// '그룹' 시작하기 버튼
Widget groupStartButton(BuildContext context, WidgetRef ref) {
  return SizedBox(
    height: 80,
    width: 330,
    child: ElevatedButton(
      onPressed: () {
        ref.read(groupModalProvider.notifier).showModal(); // 모달 열기
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // 배경색
        foregroundColor: Colors.black, // 텍스트색
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // 버튼 라운딩
        ),
      ),
      child: const Text("시작하기", style: TextStyle(fontSize: 25)),
    ),
  );
}

// 모달창 띄었을 때 제스처 (뒷 배경 클릭 시)
Widget modalGesture(BuildContext context, WidgetRef ref) {
  return GestureDetector(
    onTap:
        () =>
            ref
                .read(groupModalProvider.notifier)
                .hideModal(), // 모달 닫기 (뒷 배경 클릭)
    child: Container(
      // ignore: deprecated_member_use
      color: Colors.black.withOpacity(0.5), // 반투명 배경
    ),
  );
}
