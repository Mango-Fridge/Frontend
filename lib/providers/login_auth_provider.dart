import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/model/login/abstract_auth.dart';
import 'package:mango/model/login/platform_auth.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/services/login/apple_auth_service.dart';
import 'package:mango/services/login/login_shared_prefs.dart';
import 'package:mango/toastMessage.dart';
import '../services/login/kakao_auth_service.dart';
import 'package:mango/services/login/terms_service.dart';

final loginLoadingProvider = StateProvider<bool>((ref) => false);

// 상태 관리를 위한 provider와 notifier
class LoginAuthNotifier extends Notifier<AuthInfo?> {
  final KakaoAuthService _kakaoAuthService = KakaoAuthService();
  final AppleAuthService _appleAuthService = AppleAuthService();
  final LoginSharePrefs _loginSharePrefs = LoginSharePrefs();
  final TermsService _termsService = TermsService();

  @override
  AuthInfo? build() => null; // 초기 상태: 로그인되지 않은 상태

  // 약관 동의 여부 업데이트
  Future<void> checkForTerms(String termsType) async {
    final Map<String, AuthInfo?> termsMap = <String, AuthInfo?>{
      'privacy policy': state?.copyWith(agreePrivacyPolicy: true),
      'terms': state?.copyWith(agreeTermsOfService: true),
    };

    state = termsMap[termsType] ?? state;

    if (termsType == 'terms' && state != null) {
      _termsService.updateTerms(state!);
    }
  }

  // 로그인
  Future<void> login(AuthPlatform platform, BuildContext context) async {
    ref.read(loginLoadingProvider.notifier).state = true;
    final authService = _getAuthService(platform); // platform에 따른 서비스 반환
    if (authService == null) return;

    state = await authService.login();

    if (state == null) {
      debugPrint("[Server] 로그인으로, 데이터 받아오기 실패");
      toastMessage(context, "로그인에 실패하였습니다.", type: ToastmessageType.errorType);
    }

    ref.read(loginLoadingProvider.notifier).state = false;
  }

  // 로그아웃
  Future<void> logout(AuthPlatform platform) async {
    final authService = _getAuthService(platform); // platform에 따른 서비스 반환
    if (authService == null) return;

    state = await authService.logout();
  }

  // 자동 로그인 기능
  Future<void> autoLogin(BuildContext context) async {
    final String? platformStr =
        await _loginSharePrefs.getPlatform(); // 로컬에 저장된 platform 가져오기
    final String? email = await _loginSharePrefs.getEmail(
      platformStr ?? '사용자',
    ); // (platform에 해당하는) 로컬에 저장된 email 가져오기

    final AuthPlatform? platform = _getPlatformFromString(
      platformStr,
    ); // platform에 따른 서비스 반환

    // 저장된 platform & email이 존재한다면,
    if (platform != null && email != null) {
      // 현재 상태 기억하기

      final authService = _getAuthService(platform); // platform에 따른 서비스 반환
      if (authService == null) return;

      state = await authService.login();
      if (state != null) {
        // 서버에서 받아온 데이터가 있을 때,
        context.go('/home'); // 메인화면으로 이동
      } else {
        debugPrint("[Server] 자동 로그인으로, 데이터 받아오기 실패");
        toastMessage(
          context,
          "서버와 연결할 수 없습니다.",
          type: ToastmessageType.errorType,
        );
        context.go('/login'); // 로그인 화면으로 이동
      }
    } else {
      debugPrint("[shared_preferences] 저장된 정보가 없어서 로그인 하지 못했습니다");
      context.go('/login'); // 로그인 화면으로 이동
    }
  }

  // 문자열을 AuthPlatform Enum으로 변환
  AuthPlatform? _getPlatformFromString(String? platformStr) {
    const Map<String, AuthPlatform> platformMap = <String, AuthPlatform>{
      'Kakao': AuthPlatform.KAKAO,
      'Apple': AuthPlatform.APPLE,
    };
    return platformMap[platformStr];
  }

  // AuthPlatform에 따른 로그인/로그아웃 서비스 반환
  dynamic _getAuthService(AuthPlatform platform) {
    return <AuthPlatform, AbstractAuth>{
      AuthPlatform.KAKAO: _kakaoAuthService,
      AuthPlatform.APPLE: _appleAuthService,
    }[platform];
  }
}

// NotifierProvider 정의
final loginAuthProvider = NotifierProvider<LoginAuthNotifier, AuthInfo?>(
  LoginAuthNotifier.new,
);
