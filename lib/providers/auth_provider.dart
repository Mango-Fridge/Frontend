import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/login/platform_auth.dart';
import 'package:mango/model/login/%08auth_model.dart';
import 'package:mango/viewModel/login/apple_auth_service.dart';
import '../viewModel/login/kakao_auth_service.dart';

// 상태 관리를 위한 provider와 notifier
class AuthNotifier extends Notifier<AuthInfo?> {
  final KakaoAuthService _kakaoAuthService = KakaoAuthService(); // 카카오 서비스
  final AppleAuthService _appleAuthService = AppleAuthService(); // 애플 서비스

  @override
  AuthInfo? build() {
    return null; // 초기 상태는 로그인되지 않은 상태
  }

  // ✅ 자동 로그인 시 상태 업데이트
  void setUser(String email) {
    state = AuthInfo(platform: AuthPlatform.kakao, email: email);
  }


  // swift 문을 통해 platform을 확인 후, 해당 플랫폼으로 로그인
  Future<void> login(AuthPlatform platform) async {
    switch (platform) {
      case AuthPlatform.kakao:
        state = await _kakaoAuthService.login();
        break;
      case AuthPlatform.apple:
        state = await _appleAuthService.login();
        break;
    }
  }

  // swift 문을 통해 platform을 확인 후, 해당 플랫폼으로 로그아웃
  Future<void> logout(AuthPlatform platform) async {
    switch (platform) {
      case AuthPlatform.kakao:
        state = await _kakaoAuthService.logout();
        break;
      case AuthPlatform.apple:
        state = await _appleAuthService.logout();
        break;
    }
  }
}

// NotifierProvider 사용
final authProvider = NotifierProvider<AuthNotifier, AuthInfo?>(
  AuthNotifier.new,
);
