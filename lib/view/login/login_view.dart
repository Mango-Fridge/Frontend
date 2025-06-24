import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/design.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/model/login/platform_auth.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// 로그인 View
class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginLoadingProvider); // 로그인 상태 bool
    final Design design = Design(context);

    // 로그인 상태를 watch
    ref.watch(loginAuthProvider);

    // 로그인 상태 변경 시 반응
    ref.listen(loginAuthProvider, (AuthInfo? previousState, newState) async {
      if (newState != null) {
        // 로그인 성공 시 홈 화면으로 이동
        context.go('/home'); // 메인화면으로 이동
      }
    });

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

                Column(
                  children: [
                    Text(
                      "Mango",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.09,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "나만의 냉장고",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            isLoading ? const CircularProgressIndicator() : Container(),
            const SizedBox(height: 50),

            _LoginButton(ref: ref), // 로그인 버튼
          ],
        ),
      ),
    );
  }
}

// 로그인 버튼
class _LoginButton extends ConsumerWidget {
  final WidgetRef ref;
  const _LoginButton({required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        spacing: 10,
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
    final isLoading = ref.watch(loginLoadingProvider);

    return SignInWithAppleButton(
      style: SignInWithAppleButtonStyle.whiteOutlined,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      height: MediaQuery.of(context).size.height * 0.05,
      onPressed:
          isLoading
              ? () {}
              : () async {
                await ref
                    .read(loginAuthProvider.notifier)
                    .login(AuthPlatform.APPLE, context);
              },
    );
  }

  // 카카오 로그인 버튼
  Widget kakaoLoginButton(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginLoadingProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: Colors.black),
          minimumSize: const Size.fromHeight(40),
        ),
        onPressed:
            isLoading
                ? null
                : () async {
                  await ref
                      .read(loginAuthProvider.notifier)
                      .login(AuthPlatform.KAKAO, context);
                },
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/kakao_symbol.png',
              width: MediaQuery.of(context).size.width * 0.045,
            ),
            const Text("카카오 로그인", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
