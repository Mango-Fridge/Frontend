import 'package:flutter/material.dart';

// 공통적으로 그룹에서 사용할 버튼
Widget groupCommonButton({
  required BuildContext context,
  required String text, // 버튼 텍스트
  required VoidCallback onPressed, // 버튼 액션
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    height: MediaQuery.of(context).size.height * 0.1,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // 배경색
        foregroundColor: Colors.black, // 텍스트색
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // 버튼 라운딩
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontSize: 25)),
    ),
  );
}