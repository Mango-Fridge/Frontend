import 'package:flutter/material.dart';

// 공통적으로 그룹에서 사용할 버튼 - riverpod 사용하지 않는 단순한 코드로, 이와 같이 생성 가능
Widget nutrientColumn(String label, String value) {
  return Column(
    children: <Widget>[
      Text(label, style: const TextStyle(fontSize: 12)),
      Text(value, style: const TextStyle(fontSize: 12)),
    ],
  );
}
