import 'package:go_router/go_router.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/refrigerator_provider.dart';
import 'package:mango/view/cook/widget/cook_view.dart';
import 'package:mango/view/cook/widget/generate_cook_view.dart';
import 'package:mango/view/home/home_view.dart';
import 'package:mango/view/refrigerator/add_content_view.dart';
import 'package:mango/view/refrigerator/search_item_view.dart';
import 'package:mango/view/refrigerator/refrigerator_view.dart';
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
    // 냉장고 화면
    GoRoute(
      path: '/refrigerator',
      builder: (context, state) => const RefrigeratorView(),
    ),
    GoRoute(
      path: '/searchContent',
      builder: (context, state) => const SearchContentView(),
    ),
    GoRoute(
      path: '/addContent',
      builder: (context, state) {
        final item = state.extra as RefrigeratorItem?;
        return AddContentView(item: item);
      },
    ),
    // 요리 화면
    GoRoute(path: '/cook', builder: (context, state) => const CookView()),
    // 요리 제작 화면
    GoRoute(
      path: '/generatecook',
      builder: (context, state) => const GenerateCookView(),
    ),
  ],
);
