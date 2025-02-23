import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/view/login/login_view.dart';
import 'package:mango/view/login/terms_overlay.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(loginAuthProvider); // 현재 로그인된 사용자 정보 가져오기
    final authNotifier = ref.read(loginAuthProvider.notifier);

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
                ElevatedButton(
                  onPressed: () async {
                    if (user != null) {
                      await authNotifier.logout(user.platform); // 해당 플랫폼에서 로그아웃
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ), // 로그인 화면으로 이동
                      );
                    }
                  },
                  child: const Text("로그아웃"),
                ),
              ],
            ),
          ),

          if (user != null && !user.isPrivacyPolicyAccepted)
            const TermsOverlay(
              key: ValueKey('privacyPolicy'),
              termsType: 'privacy policy',
            ),
          if (user != null &&
              !user.isTermsAccepted &&
              user.isPrivacyPolicyAccepted)
            const TermsOverlay(key: ValueKey('terms'), termsType: 'terms'),
        ],
      ),
    );
  }
}
