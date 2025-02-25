import 'package:flutter/widgets.dart';

class Design {
  final double screenWidth;
  final double screenHeight;

  // 생성자에서 초기화
  Design(BuildContext context)
    : screenWidth = MediaQuery.of(context).size.width,
      screenHeight = MediaQuery.of(context).size.height;
}
