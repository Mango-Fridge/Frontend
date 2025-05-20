import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';

// 그룹이 없을 때 사용하는 버튼
Widget groupActionButton({
  required BuildContext context,
  required String text, // 버튼 텍스트
  required IconData icon, // 아이콘
  VoidCallback? onPressed, // 버튼 액션
}) {
  return Consumer(
    builder: (context, ref, child) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.11,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber, // 배경색
            foregroundColor: Colors.black, // 텍스트색
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // 버튼 라운딩
            ),
          ),
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.black, size: Design.appTitleFontSize),
              const SizedBox(height: 9),
              Text(
                text,
                style: const TextStyle(
                  fontSize: Design.appTitleFontSize,
                  fontWeight: FontWeight.w300, // 굵기 Light
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
