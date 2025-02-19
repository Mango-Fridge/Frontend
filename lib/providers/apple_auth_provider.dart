import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/user_model.dart';
import 'package:mango/viewModel/login/apple_auth_service.dart.dart';

// 상태 관리를 위한 provider와 notifier
class AuthNotifier extends Notifier<UserInfo?> {
  final AppleAuthService _authService = AppleAuthService();

  @override
  UserInfo? build() {
    return null; // 초기 상태는 로그인되지 않은 상태
  }

  Future<void> signInWithApple() async {
    state = await _authService.login();
  }

  Future<void> signOut() async {
    state = await _authService.logout();
  }
}

final NotifierProvider<AuthNotifier, UserInfo?> authProvider =
    NotifierProvider<AuthNotifier, UserInfo?>(AuthNotifier.new);
