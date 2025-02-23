import 'package:mango/model/login/platform_auth.dart';

// 로그인 정보를 담기 위한 모델
class AuthInfo {
  final AuthPlatform platform; // 플랫폼
  final String? email; // 이메일
  final String? nickname; // 닉네임
  final bool? isPrivacyPolicyAccepted; // 개인정보 수집 이용 동의
  final bool? termsAcceptedProvider; // 서비스 이용 약관 동의

  AuthInfo({required this.platform, this.email, this.nickname, this.isPrivacyPolicyAccepted, this.termsAcceptedProvider});
}
