import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/kakao_auth_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:mango/providers/apple_auth_provider.dart';

import '../../model/login/user_model.dart';

// 로그인 화면
class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authProvider); // 계정 Provider
    final UserInfo? kakaoUser = ref.watch(kakaoAuthProvider);

    return Scaffold(
      body: Center(
        child:
            kakaoUser == null
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (Platform.isIOS) // 현재 기기가 iOS가 아닐 때, 애플로그인 버튼이 안보임
                      SignInWithAppleButton(
                        onPressed: () async {
                          await ref
                              .read(authProvider.notifier)
                              .signInWithApple(); // 버튼을 눌렀을 시 함수 실행
                        },
                      ),
                    ElevatedButton(
                      onPressed: () async {
                        await ref.read(kakaoAuthProvider.notifier).kakaoLogin();
                      },
                      child: const Text("카카오로그인"),
                    ),
                  ],
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (kakaoUser.email != null)
                      Text('Email: ${kakaoUser.email}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(kakaoAuthProvider.notifier).kakaoLogout();
                      },
                      child: const Text('로그아웃'),
                    ),
                  ],
                ),
      ),
    );
  }
}
