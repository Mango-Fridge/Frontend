import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/login_auth_provider.dart';

// loginAuthProvider -> autoLogin는 riverpod을 이용한 것이기에 ConsumerStatefulWidget을 extends
// ConsumerWidget은 initState() 사용 불가.
class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  // 스플래쉬 뷰가 나타날 때 가장 처음 실행할 함수
  @override
  void initState() {
    super.initState();

    // 2초 대기 후 자동 로그인 실행 (로그인 여부 확인하는 동안 뷰 유지하기 위해)
    Future.delayed(const Duration(seconds: 2), () {
      // 비동기 작업의 결과를 위젯에 반영하기 전에 위젯이 여전히 유효한 상태인지 확인
      if (mounted) {
        // 로그인 관련 함수 provider(loginAuthProvider)를 이용하여 자동 로그인 함수 실행
        ref.read(loginAuthProvider.notifier).autoLogin(context, ref);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()), // 로딩 화면
    );
  }
}
