import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/design.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/model/login/platform_auth.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/view/home/home_view.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// 로그인 View
class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Design design = Design(context);

    // 로그인 상태를 watch
    ref.watch(loginAuthProvider);

    // 로그인 상태 변경 시 반응
    ref.listen(loginAuthProvider, (AuthInfo? previousState, newState) {
      if (newState != null) {
        // 로그인 성공 시 홈 화면으로 이동
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (context) => HomeView()));
      }
    });

    return Scaffold(
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
                const Text("Mango"),
              ],
            ),
            const SizedBox(height: 100),
            _LoginButton(ref: ref), // 로그인 버튼
          ],
        ),
      ),
    );
  }
}

// 로그인 버튼
class _LoginButton extends StatelessWidget {
  final WidgetRef ref;
  const _LoginButton({required this.ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          // (IOS 한정) 애플 로그인 버튼
          if (Platform.isIOS) appleLoginButton(context, ref),
          kakaoLoginButton(context, ref), // 카카오 로그인 버튼
        ],
      ),
    );
  }

  // 애플 로그인 버튼
  Widget appleLoginButton(BuildContext context, WidgetRef ref) {
    return SignInWithAppleButton(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      height: 40,
      onPressed: () async {
        await ref.read(loginAuthProvider.notifier).login(AuthPlatform.apple);
      },
    );
  }

  // 카카오 로그인 버튼
  Widget kakaoLoginButton(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size.fromHeight(40),
      ),
      onPressed: () async {
        await ref.read(loginAuthProvider.notifier).login(AuthPlatform.kakao);
      },
      child: const Text("카카오로그인"),
    );
  }
}
