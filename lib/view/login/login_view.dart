import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/providers/kakao_auth_provider.dart';
import 'package:mango/view/home/home_view.dart';
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
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              spacing: 30,
              children: <Widget>[
                Image.asset("assets/images/title.png", scale: 5),
                const Text("Mango"),
              ],
            ),
            Container(
              width: 300,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                spacing: 10,
                children: <Widget>[
                  // IOS 사용자는 애플 로그인 버튼 표시
                  Platform.isIOS ? appleLoginButton(context, ref) : Container(),
                  // 카카오 로그인 버튼
                  kakaoLoginButton(context, ref),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 애플 로그인 버튼
  Widget appleLoginButton(BuildContext context, WidgetRef ref) {
    return SignInWithAppleButton(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      height: 40,
      onPressed: () async {
        await ref
            .read(authProvider.notifier)
            .signInWithApple(); // 버튼을 눌렀을 시 함수 실행
        // (애플 로그인이 성공했을 때, 로직 추가)
        // 현재는 메인화면으로 넘어가게만 유도 (추후 추가)
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const HomeView()));
      },
    );
  }

  // 카카오 로그인 버튼
  Widget kakaoLoginButton(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size.fromHeight(40), // 높이만 맞추고 가로는 최대
      ),
      onPressed: () async {
        await ref.read(kakaoAuthProvider.notifier).kakaoLogin();
        // (카카오 로그인이 성공했을 때, 로직 추가)
        // 현재는 메인화면으로 넘어가게만 유도 (추후 추가)
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const HomeView()));
      },
      child: const Text("카카오로그인"),
    );
  }
}
