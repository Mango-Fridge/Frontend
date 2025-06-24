import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mango/model/login/platform_auth.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

// 로그인 정보를 담기 위한 모델
@freezed
abstract class AuthInfo with _$AuthInfo {
  const factory AuthInfo({
    AuthPlatform? oauthProvider, // 플랫폼
    int? usrId, // 사용자 ID
    String? email, // 이메일
    String? usrNm, // 닉네임
    @Default(false) bool? agreePrivacyPolicy, // 개인정보 수집 이용 동의
    @Default(false) bool? agreeTermsOfService, // 서비스 이용 약관 동의
  }) = _AuthInfo;

  factory AuthInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthInfoFromJson(json);
}
