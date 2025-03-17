# mango

냉장고 물품 관리 및 '전국통합식품영양성분정보표준데이터'API를 활용한 토이 프로젝트

## VERSION 1.0.7 (2025-03-15)
 - 메인화면 (물품 상세 추가 화면)
   - 수량 값 입력시, 숫자 이외의 값이 들어가면 예외처리
   - 검색해서 데이터를 받아오면, "카테고리" 설정을 하지 못하게 처리
   - 스크롤 추적
   - 메인화면에 마감 임박 관련 View 추가
 - 그룹
   - 유효성 검사를 위한 CircularProgressIndicator()
   - ToastMessage 적용
 - 요리
   - 요리 제목 width에 따른 생략 처리 ("과...")
   - 영양 성분표 overflow 수정
   - Gesture를 활용한 BottomSheet 처리
   - 일부 코드 리팩토링
   - Navigator 제거 및 go_router 변경
   - Memo 높이 상한선 설정 (최대 줄 수 = 3)

### [이전 버전 기록](https://docs.google.com/document/d/1jGvCaHdyLdExCCWo95xoGkFYdY4Mc1hrtk55fEWGx1o/edit?usp=sharing) <br>

## 주요 라이브러리

| 이름           | 설명                           | 버전               |
| ------------ | ---------------------------- | ----------------- |
| `Flutter`      | 개발 프레임워크       | `3.29.0` |
| `Dart`      | 개발 프로그래밍 언어       | `3.7.0` |
| `flutter_riverpod`      | 상태관리 패키지       | `2.6.1` |
| `go_router`      | 라우팅 패키지       | `14.8.1` |
| `flutter_dotenv`      | 환경 변수 설정 패키지       | `5.2.1` |
| `shared_preferences`      | 로컬 저장소 패키지       | `2.5.2` |
| `sign_in_with_apple`      | Apple 로그인 패키지       | `2.6.1` |
| `kakao_flutter_sdk`      | Kakao 로그인 패키지       | `1.9.6` |
| `fluttertoast`      | Toast Message 패키지       | `8.2.12` |
