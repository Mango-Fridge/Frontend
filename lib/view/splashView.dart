import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:mango/providers/login_auth_provider.dart';

// loginAuthProvider -> autoLogin는 riverpod을 이용한 것이기에 ConsumerStatefulWidget을 extends
// ConsumerWidget은 initState() 사용 불가.
class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    _initAutoLogin(); // 자동 로그인
  }

  void _initAutoLogin() {
    // initState 에서 안전하게 실행시키기 위함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 2초 대기 후 자동 로그인 실행 (로그인 여부 확인하는 동안 뷰 유지하기 위해)
      Future.delayed(const Duration(seconds: 2), () {
        // 비동기 작업의 결과를 위젯에 반영하기 전에 위젯이 여전히 유효한 상태인지 확인
        if (!mounted) return;
        // 로그인 관련 함수 provider(loginAuthProvider)를 이용하여 자동 로그인 함수 실행
        ref.read(loginAuthProvider.notifier).autoLogin(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Design design = Design(context);

    return Scaffold(
      backgroundColor: design.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              spacing: 30,
              children: <Widget>[
                Image.asset(
                  "assets/images/title.png",
                  scale: design.splashImageSize,
                ),
                Text(
                  "Mango",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
