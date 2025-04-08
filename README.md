# mango

냉장고 물품 관리 및 '전국통합식품영양성분정보표준데이터'API를 활용한 토이 프로젝트

## VERSION 1.1.1 (2025-04-08)
 - 메인화면
   - 그룹이 없을 때, 상호작용 버튼이 안보이게 수정
   - 유통 기한 임박 관련된 View 수정
   - 물품 추가에서, 검색 API & 페이징 적용
 - 요리
   - List 요소를 삭제할 때, 제대로 삭제가 되지 않는 현상 수정
   - toastMessage 적용
   - 요리 제목 & 재료가 최소 1개 이상 있을때만 "추가하기" 버튼 활성화

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
