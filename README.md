# mango

냉장고 물품 관리 및 '전국통합식품영양성분정보표준데이터'API를 활용한 토이 프로젝트

## VERSION 1.1.6 (2025-06-04)
 - 초기화면
   - 디자인 전면 개선
   - 로직 일부 수정
 - 메인화면
   - padding 값 조절
   - 물품 변경시, 해당 물품에 대한 backgroundColor 변경 (시각 update)
   - 물품 변경시, +/- 표시되게 수정
   - 물품 추가에서 제목 제한수 해제
   - 물품 임박 위젯이 제목이 길어져서 overflow 나는 현상 수정
 - 그룹
   - Figma 디자인과 동일하게 수정
   - 냉장고 생성시, TextField height값이 변동되는 현상 수정
 - 요리
   - 디자인 수정
   - 하단 로직 개선
   - 요리 추가에서 물품 선택시, 데이터가 사라지는 현상 수정
   - 요리 추가에서 선택된 물품 리스트 개수 출력
   - 요리 추가에서 선택된 물품을 다시 눌러서 개수를 조정할 수 있는 기능 추가
   - 일부 화면을 ScrollView로 변경
   - 요리 리스트에서 재료 글자 수가 일정 범위를 넘어서면 ... 표기
   - 그 외 자잘한 문제 수정
 - 설정
   - 디자인 전면 개선
   - 닉네임 변경 기능 추가
   - 회원탈퇴 추가
   - 약관 관련 View 추가
 - 기타
   - 로그인 처리 로직 수정
   - 이미지 추가 및 변경
   - 앱 아이콘 추가

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
