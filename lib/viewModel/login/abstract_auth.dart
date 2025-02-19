// 추상화 클래스를 이용하여 로그인 구현 일관되게 관리
import 'package:mango/model/user_model.dart';

abstract class AbstractAuth {
  Future<UserInfo?> login(); // 로그인
  Future<UserInfo?> logout(); // 로그아웃
}