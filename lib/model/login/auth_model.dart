// 사용자 정보를 담기 위한 모델
import 'package:mango/model/login/platform_auth.dart';

class AuthInfo {
  final AuthPlatform platform; // 플랫폼
  final String? email; // 이메일

  AuthInfo({required this.platform, this.email});
}
