import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/providers/group_state_provider.dart';

// 공통적으로 그룹 모달에서 사용할 상단바
Widget groupModalTitle({
  required BuildContext context,
  required String textTitle, // 타이틀
  required String textSub, // 추가 타이틀
}) {
  return Consumer(
    builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // 위쪽 정렬
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: 25,
              onPressed: () {
                final currentState = ref.read(groupModalStateProvider);
                if (currentState == GroupModalState.start) {
                  context.pop(); // go_router 사용하여 해당 모달창 닫기
                } else {
                  ref.read(groupModalStateProvider.notifier).state = GroupModalState.start; // 그룹 모달 시작 뷰
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                children: <Widget>[
                  Text(
                    textTitle,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    textSub,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
