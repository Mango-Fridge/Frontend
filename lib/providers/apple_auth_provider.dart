import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/user_model.dart';
import 'package:mango/viewModel/login/apple_auth_service.dart.dart';

// 상태 관리를 위한 provider와 notifier
final StateNotifierProvider<AuthNotifier, UserInfo?> authProvider =
    StateNotifierProvider<AuthNotifier, UserInfo?>((ref) {
      return AuthNotifier();
    });

class AuthNotifier extends StateNotifier<UserInfo?> {
  AuthNotifier() : super(null);

  final AppleAuthService _authService = AppleAuthService();

  Future<void> signInWithApple() async {
    state = await _authService.login();
  }

  Future<void> signOut() async {
    state = await _authService.logout();
  }
}
