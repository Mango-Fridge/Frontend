import 'package:mango/model/login/user_model.dart';

// 로그인 추상화
abstract class AbstractAuth {
  Future<UserInfo?> login(); // 로그인
  Future<UserInfo?> logout(); // 로그아웃
}
