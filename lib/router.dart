import 'package:go_router/go_router.dart';
import 'package:mango/view/home/home_view.dart';
import 'package:mango/view/login/login_view.dart';
import 'package:mango/view/splashView.dart';

// 라우터 관리(go_router)
final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true, // 라우팅 디버깅 로그 활성화
  routes: <RouteBase>[
    // 초기 화면
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    // 로그인 화면
    GoRoute(path: '/login', builder: (context, state) => const LoginView()),
    // 메인 화면
    GoRoute(path: '/home', builder: (context, state) => const HomeView()),
  ],
);
