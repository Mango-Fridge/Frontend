import 'package:flutter/material.dart';
import 'package:mango/view/login/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // 로그인 로직에 따라 HomeView / LoginView 처리
  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}
