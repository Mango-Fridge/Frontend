import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/login/user_model.dart';
import '../viewModel/login/kakao_auth_service.dart';

// 상태 관리를 위한 provider와 notifier
class AuthNotifier extends Notifier<UserInfo?> {
  final KakaoAuthService _authService = KakaoAuthService();

  @override
  UserInfo? build() {
    return null; // 초기 상태는 로그인되지 않은 상태
  }

  Future<void> kakaoLogin() async {
    state = await _authService.login(); // 카카오 로그인 후 유저 정보 업데이트
  }

  Future<void> kakaoLogout() async {
    state = await _authService.logout(); // 카카오 로그아웃 후 유저 정보 업데이트
  }
}

// NotifierProvider 사용
final kakaoAuthProvider = NotifierProvider<AuthNotifier, UserInfo?>(
  AuthNotifier.new,
);
