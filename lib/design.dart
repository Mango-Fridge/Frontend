import 'package:flutter/widgets.dart';

class Design {
  final double screenWidth; // 시스템 가로
  final double screenHeight; // 시스템 세로
  final double splashImageSize; // splash & login 로고 이미지 크기 (scale)
  final double termsOverlayWidth; // 약관 동의 overlay 가로 크기
  final double termsOverlayHeight; // 약관 동의 overlay 세로 크기
  final double termsAgreeButtonHeight; // 약관 동의 버튼 세로 크기
  final double homeImageSize; // refrigerator 로고 이미지 크기

  // 생성자에서 초기화
  Design(BuildContext context)
    : screenWidth = MediaQuery.of(context).size.width,
      screenHeight = MediaQuery.of(context).size.height,
      splashImageSize = MediaQuery.of(context).size.height * 0.005,
      termsOverlayWidth = MediaQuery.of(context).size.width * 0.9,
      termsOverlayHeight = MediaQuery.of(context).size.height * 0.7,
      termsAgreeButtonHeight = MediaQuery.of(context).size.height * 0.05,
      homeImageSize = MediaQuery.of(context).size.width * 0.12;
}
