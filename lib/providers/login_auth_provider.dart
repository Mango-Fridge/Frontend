import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/login/platform_auth.dart';
import 'package:mango/model/login/%08auth_model.dart';
import 'package:mango/view/home/home_view.dart';
import 'package:mango/view/login/login_view.dart';
import 'package:mango/viewModel/login/apple_auth_service.dart';
import 'package:mango/viewModel/login/login_shared_prefs.dart';
import '../viewModel/login/kakao_auth_service.dart';

// 상태 관리를 위한 provider와 notifier
class LoginAuthNotifier extends Notifier<AuthInfo?> {
  final KakaoAuthService _kakaoAuthService = KakaoAuthService(); // 카카오 서비스
  final AppleAuthService _appleAuthService = AppleAuthService(); // 애플 서비스
  final LoginSharePrefs loginSharePrefs = LoginSharePrefs(); // 로그인 관련 뷰모델

  @override
  AuthInfo? build() {
    return null; // 초기 상태는 로그인되지 않은 상태
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

  // 자동 로그인 기능
  Future<void> autoLogin(BuildContext context, WidgetRef ref) async {
    String? email = await loginSharePrefs.getEmail();
    String? platformStr = await loginSharePrefs.getPlatform();
    AuthPlatform? platform;

    // AuthInfo에 platform은 열거형이기에 사용
    // 즉, 로컬에 저장된 (String)platform을 (열거형)platform으로 만들어 AuthInfo 이용
    if (platformStr == 'Kakao') {
      platform = AuthPlatform.kakao;
    } else if (platformStr == 'Apple') {
      platform = AuthPlatform.apple;
    }
    
    // email이 null이 아니고 platform도 null이 아닐 때 HomeView로 이동
    if (email != null && platform != null) {
      state = AuthInfo(platform: platform, email: email); // AuthInfo 객체를 생성하여 반환

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }
}

// NotifierProvider 사용
final loginAuthProvider = NotifierProvider<LoginAuthNotifier, AuthInfo?>(
  LoginAuthNotifier.new,
);
