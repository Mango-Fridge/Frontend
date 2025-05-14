# mango

냉장고 물품 관리 및 '전국통합식품영양성분정보표준데이터'API를 활용한 토이 프로젝트

## VERSION 1.1.5 (2025-05-14)
 - 로그인
   - UI 전면 개선 (+ SplashView)
   - 로그인 시도중일때, 시각적으로 알수있게 Progress Indicator 적용 (+ 버튼 disabled)
   - JWT 인증 방식 적용 (Kakao / Apple)
   - 서버 에러 관련 처리 (Timeout, 400 등)
 - 메인화면
   - 메인 & 물품추가 관련 UI 개선
 - 요리
   - Figma에 맞게 UI 개선 및 구조 변경
   - 요리 추가에서 검색 로직 변경 (물품 추가와 유사)
   - 요리 리스트에서 삭제 스와이프 제거 (=> 상세화면에서 가능하게 변경)
   - 중분류명이 누락된 이슈 수정
   - 요리가 존재하지 않을때, 냉장고명과 개수가 출력되지 않게 수정
   - log 관련 수정

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
| `Freezed`      | 데이터 모델 정의 패키지       | `3.0.0` |
| `Retrofit`      | Rest api를 위한 Http 클라이언트 생성 패키지       | `4.4.2` |
| `json_serializable`      | Json 데이터 직렬화 패키지     | `6.9.4` |
