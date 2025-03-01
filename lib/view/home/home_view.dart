import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/view/login/terms_overlay.dart';

// 메인화면
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  // 로그인된 사용자 정보와 AuthNotifier를 가져오는 메소드
  AuthInfo? get user => ref.watch(loginAuthProvider);

  // 로그아웃 처리 메소드
  Future<void> _logout() async {
    final authNotifier = ref.read(loginAuthProvider.notifier);
    if (user != null) {
      await authNotifier.logout(user!.platform);
      context.go('/login'); // 로그인 화면
    }
  }

  // CookView로 이동하는 메소드
  void _navigateToCookView() {
    context.go('/cook'); // cook_view.dart로 이동하는 경로
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "환영합니다, ${user?.email ?? '사용자'}님!",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: _logout, child: const Text("로그아웃")),
                const SizedBox(height: 10), // 로그아웃 버튼과 새 버튼 사이 간격 추가
                ElevatedButton(
                  onPressed: _navigateToCookView, // CookView로 이동
                  child: const Text("요리 화면으로 이동"),
                ),
              ],
            ),
          ),
          _buildTermsOverlay(), // 약관 동의 화면
        ],
      ),
    );
  }

  // TermsOverlay 표시 여부를 결정하는 메소드
  Widget _buildTermsOverlay() {
    // 유저가 없으면 화면을 띄우지 않음.
    if (user == null) return const SizedBox.shrink();

    // 유저가 동의를 하지 않았을 때,
    if (user!.isPrivacyPolicyAccepted) {
      return const TermsOverlay(
        key: ValueKey('privacyPolicy'),
        termsType: 'privacy policy',
      );
    }
    // 유저가 동의를 하지 않았을 때,
    if (user!.isTermsAccepted) {
      return const TermsOverlay(key: ValueKey('terms'), termsType: 'terms');
    }

    // 유저가 모든 동의를 했을경우, 화면을 띄우지 않음.
    return const SizedBox.shrink();
  }
}
