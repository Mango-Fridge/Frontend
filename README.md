# mango

냉장고 물품 관리 및 '전국통합식품영양성분정보표준데이터'API를 활용한 토이 프로젝트

## VERSION 1.0.5 (2025-03-11)
 - 메인화면
   - 물품 추가 검색필드
   - 물품 추가 상세정보 로직
   - View 전환시, state 초기화
 - 그룹
   - 생성하기에서 타이머 제거 
   - 코드 리팩토링 (Guard clause)

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
