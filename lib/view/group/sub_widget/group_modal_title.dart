import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/state/group_enum_state.dart';
import 'package:mango/providers/group_enum_state_provider.dart';

// 공통적으로 그룹 모달에서 사용할 상단바
Widget groupModalTitle({
  required BuildContext context,
  required String textTitle, // 타이틀
}) {
  return Consumer(
    builder: (context, ref, child) {
      final currentState = ref.read(groupModalStateProvider);
      final double fontSizeMediaQuery =
          MediaQuery.of(context).size.width; // 폰트 사이즈

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // 위쪽 정렬
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.close),
              iconSize: 25,
              onPressed: () {
                context.pop(); // go_router 사용하여 해당 모달창 닫기
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                children: <Widget>[
                  Text(
                    textTitle,
                    style: TextStyle(
                      fontSize: fontSizeMediaQuery * 0.06,
                      fontWeight: FontWeight.bold,
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
