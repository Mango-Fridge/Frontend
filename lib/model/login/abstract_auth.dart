import 'package:mango/model/login/auth_model.dart';

// 로그인 추상화
abstract class AbstractAuth {
  Future<AuthInfo?> login(); // 로그인
  Future<AuthInfo?> logout(); // 로그아웃
  Future<AuthInfo?> deleteUser(AuthInfo authInfo); // 회원탈퇴
}
