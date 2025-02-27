import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mango/view/home/home_view.dart';
import 'package:mango/view/login/login_view.dart';
import 'package:mango/view/splashView.dart';

// 화면 이동 (go_router)
class RouterPage {
  final GoRouter routers = GoRouter(
    routes: <RouteBase>[
      // 초기 화면
      GoRoute(
        path: '/',
        builder:
            (BuildContext context, GoRouterState state) => const SplashView(),
      ),
      // 로그인 화면
      GoRoute(
        path: '/login',
        builder:
            (BuildContext context, GoRouterState state) => const LoginView(),
      ),
      // 메인 화면
      GoRoute(
        path: '/home',
        builder:
            (BuildContext context, GoRouterState state) => const HomeView(),
      ),
    ],
  );
}
