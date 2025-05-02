import 'package:flutter/widgets.dart';

class Design {
  static const double appTitleFontSize = 25;
  static const double normalFontSize0 = 12;
  static const double normalFontSize1 = 16;
  static const double normalFontSize2 = 22;
  static const double normalFontSize3 = 24;
  static const double normalFontSize4 = 30;
  static const double tabBarSelectedFontSize = 20;
  static const double tabBarUnSelectedFontSize = 18;
  static const double contentRowNameFontSize = 13;
  static const double contentRowExpFontSize = 12;
  static const double countButtonFontSize = 20;
  static const double setCountViewFontSize = 13;
  static const double itemNameFontSize = 22;
  final double screenWidth; // 시스템 가로
  final double screenHeight; // 시스템 세로
  final double marginAndPadding; // 기본 마진 및 패딩
  final double nutritionViewMarginAndPadding; // 영양 성분 뷰 마진 및 패딩
  final double splashImageSize; // splash & login 로고 이미지 크기 (scale)
  final double termsOverlayWidth; // 약관 동의 overlay 가로 크기
  final double termsOverlayHeight; // 약관 동의 overlay 세로 크기
  final double termsAgreeButtonHeight; // 약관 동의 버튼 세로 크기
  final double contentUpdateViewHeight; // 물품 수량 조절 뷰 높이
  final double addContentTextWidth; // AddContentView 항목의 Text 가로 크기
  final double
  addContentNutritionTextWidth; // AddContentView Nutrition 항목의 Text 가로 크기
  final double homeImageSize; // refrigerator 로고 이미지 크기
  final double homeBottomHeight; // 메인화면 BottomSheet 높이
  final double cartImageSize; // cart 이미지 크기
  final Color mainColor; // 메인 컬러
  final Color subColor; // 서브 컬러
  final Color textFieldColor; // 텍스트 필드 내부 컬러
  final Color textFieldborderColor; // 텍스트 필드 외곽 컬러
  final Color cancelColor; // 취소 컬러
  final Color cookBtnColor; // 요리 버튼 컬러

  final double settingBtnWidth;
  final double settingBtnHeight;

  // 생성자에서 초기화
  Design(BuildContext context)
    : screenWidth = MediaQuery.of(context).size.width,
      screenHeight = MediaQuery.of(context).size.height,
      marginAndPadding = MediaQuery.of(context).size.width * 0.022,
      nutritionViewMarginAndPadding = MediaQuery.of(context).size.width * 0.030,
      splashImageSize = MediaQuery.of(context).size.height * 0.007,
      termsOverlayWidth = MediaQuery.of(context).size.width * 0.95,
      termsOverlayHeight = MediaQuery.of(context).size.height * 0.7,
      termsAgreeButtonHeight = MediaQuery.of(context).size.height * 0.05,
      contentUpdateViewHeight = MediaQuery.of(context).size.height * 0.20,
      addContentTextWidth = MediaQuery.of(context).size.width * 0.30,
      addContentNutritionTextWidth = MediaQuery.of(context).size.width * 0.25,
      homeImageSize = MediaQuery.of(context).size.width * 0.12,
      homeBottomHeight = 50,
      cartImageSize = MediaQuery.of(context).size.width * 0.35,
      mainColor = const Color.fromRGBO(255, 205, 72, 1.0),
      subColor = const Color.fromRGBO(255, 244, 216, 1.0),
      textFieldColor = const Color.fromRGBO(255, 238, 192, 1.0),
      textFieldborderColor = const Color.fromRGBO(195, 142, 1, 1.0),
      cancelColor = const Color.fromRGBO(255, 208, 208, 1.0),
      cookBtnColor = const Color.fromRGBO(219, 254, 128, 1.0),

      settingBtnWidth = 120,
      settingBtnHeight = 30;
}
