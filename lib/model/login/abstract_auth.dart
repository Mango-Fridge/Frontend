import 'package:mango/model/login/%08auth_model.dart';

// 로그인 추상화
abstract class AbstractAuth {
  Future<AuthInfo?> login(); // 로그인
  Future<AuthInfo?> logout(); // 로그아웃
}
