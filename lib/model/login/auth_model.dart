import 'package:mango/model/login/platform_auth.dart';

// 로그인 정보를 담기 위한 모델
class AuthInfo {
  final AuthPlatform platform; // 플랫폼
  final int? userId; // 사용자 ID
  final String? email; // 이메일
  final String? nickname; // 닉네임
  final bool isPrivacyPolicyAccepted; // 개인정보 수집 이용 동의
  final bool isTermsAccepted; // 서비스 이용 약관 동의

  AuthInfo({
    required this.platform,
    this.userId,
    this.email,
    this.nickname,
    this.isPrivacyPolicyAccepted = false,
    this.isTermsAccepted = false,
  });

  AuthInfo copyWith({
    int? userId,
    String? email,
    String? nickname,
    bool? isPrivacyPolicyAccepted,
    bool? isTermsAccepted,
  }) {
    return AuthInfo(
      platform: platform,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      isPrivacyPolicyAccepted:
          isPrivacyPolicyAccepted ?? this.isPrivacyPolicyAccepted,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
    );
  }
}
